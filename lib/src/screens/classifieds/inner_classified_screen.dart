import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/classifieds/classified_details_cubit.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/screens/marketplace/widgets/classifieds_description/classifieds_description.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';
import 'package:kima/src/utils/widgets/customs/custom_carousel_indicator/custom_carousel_indicator.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/configs.dart';

class InnerClassified extends StatefulWidget {
  InnerClassified({
    Key? key,
    this.category = 'for_sale',
    this.title = 'House for sale',
    this.price = '0',
    this.createdAt = '',
    this.id = 0,
    this.description = 'N/A',
    this.location = 'N/A',
    this.joinedDate = '2023',
    this.favoriteUserId = 3,
    this.onFavorite,
    this.image = '',
  }) : super(key: key);

  static const route = '/inner-classified';

  String category;
  String title;
  String price;
  String createdAt;
  final int id;
  String description;
  String location;
  final String joinedDate;
  final int favoriteUserId;
  final String image;

  final ValueChanged<bool>? onFavorite;

  @override
  State<InnerClassified> createState() => _InnerClassifiedState();
}

class _InnerClassifiedState extends State<InnerClassified> with DialogMixins {
  late MemberProvider memberProvider;
  late List<String> images;
  late String username = ''; // Change from List to String for the username

  @override
  void initState() {
    super.initState();
    memberProvider = MemberProvider();
    images = [
      widget.image,
    ];
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl = '$baseUrlDev/classifieds/1${widget.id}';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          widget.category = data['data'][0]['category'] ?? 'for_sale';
          widget.title = data['data'][0]['title'] ?? 'House for sale';
          widget.price = data['data'][0]['price']?.toString() ?? '0';
          widget.createdAt = data['data'][0]['createdAt'] ?? '';
          widget.description = data['data'][0]['description'] ?? 'N/A';
          widget.location = data['data'][0]['location'] ?? 'N/A';

          // If user id is available in the response, display it as the username
          username = data['data'][0]['userId']?.toString() ?? '';

          // Extract other properties based on your API response
        });
      } else {
        print('Failed to load data. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Map<String, dynamic> mapCategory = {
    'events': 'events',
    'for_sale': 'for sale',
    'misc': 'miscellaneous',
    'job_posting': 'job posting',
    'real_estate': 'real estate'
  };

  String getFormattedDate({
    required String date,
    String format = 'MMM dd, yyyy',
  }) {
    try {
      final parsed = DateTime.parse(date);
      final DateFormat formatter = DateFormat(format);
      final String formatted = formatter.format(parsed);
      return formatted;
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency();

    return HeaderWrapper(
      titleHeader: 'Description',
      onBack: () => Navigator.pop(context),
      elevation: 1,
      actions: [
        CircularIconButton(
          icon: Assets.icons.moreVertical.svg(),
          bgColor: AppColors.lightGrey20,
          width: 50.0,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => showDescriptionModalBottomSheet(context),
        ),
      ],
      toolbarHeight: 95,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassifiedsHeader(
              category: mapCategory[widget.category] ?? 'N/A',
              title: widget.title,
              subtitle: widget.price.isNotEmpty
                  ? formatCurrency.format(double.parse(widget.price))
                  : '',
              author: username.isNotEmpty ? username[0] : 'N/A',
              listingDate: getFormattedDate(
                date: widget.createdAt,
                format: 'dd.MM.yyyy',
              ),
            ),
            CustomCarouselIndicator(
              height: 300.0,
              children: images.map((image) {
                return Image.asset(
                  image.isNotEmpty ? image : 'Image not Found',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClassifiedsUserFavorite(
                    id: widget.id,
                    // user: username[widget.favoriteUserId],
                    user: username.toString(),
                    joinedDate: widget.joinedDate,
                    onFavorite: widget.onFavorite,
                  ),
                  const VerticalSpace(20.0),
                  const ClassifiedsMessageBox(),
                  if (widget.description.isNotEmpty)
                    ClassifiedsDescriptionBox(widget.description),
                  if (widget.location.isNotEmpty ||
                      widget.price.isNotEmpty) ...[
                    const VerticalSpace(30.0),
                    const CustomText(
                      'Additional Details',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    const VerticalSpace(15.0),
                    if (widget.location.isNotEmpty)
                      ClassifiedsItemDetail(
                        label: 'Location',
                        value: widget.location,
                      ),
                    if (widget.price.isNotEmpty)
                      ClassifiedsItemDetail(
                        label: 'Price',
                        value:
                            formatCurrency.format(double.parse(widget.price)),
                      ),
                  ],
                  const VerticalSpace(60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
