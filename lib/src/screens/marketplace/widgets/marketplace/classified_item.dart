import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/classifieds/classified_details_cubit.dart';
import 'package:kima/src/data/models/classifieds_model.dart';
import 'package:kima/src/screens/classifieds/classifieds_screen.dart';
import 'package:kima/src/screens/classifieds/inner_classified_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/datetime.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../utils/helpers/shared_pref_helpers.dart';

class ClassifiedItem extends StatefulWidget {
  ClassifiedItem({Key? key}) : super(key: key);

  @override
  State<ClassifiedItem> createState() => _ClassifiedItemState();
}

class _ClassifiedItemState extends State<ClassifiedItem> {
  late ClassifiedDetailsCubit _classifiedDetailsCubit;
  final formatCurrency = NumberFormat.simpleCurrency();
  List<Classified> classifiedList = [];

  Widget categoryChecker({required Classified classified}) {
    switch (classified.category) {
      case 'events':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classified.title!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
                Text(
                  classified.price ?? 'free',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconClock.svg(),
                const HorizontalSpace(5),
                Text(
                  '${getFormattedDate(date: classified.eventDate ?? '')} - ${getFormattedTime(classified.eventTime ?? '')}',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        );
      case 'for_sale':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classified.title!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
                Text(
                  classified.price != null
                      ? formatCurrency.format(double.parse(classified.price!))
                      : 'free',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconBathroom.svg(),
                Text(
                  classified.itemCondition!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
                const HorizontalSpace(10),
                Assets.icons.iconBedroom.svg(),
                const HorizontalSpace(5),
                Text(
                  classified.itemCondition!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        );
      case 'job_posting':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classified.title!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
                Text(
                  classified.price != null
                      ? formatCurrency.format(double.parse(classified.price!))
                      : 'free',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconJob.svg(),
                const HorizontalSpace(5),
                Text(
                  classified.itemCondition!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        );
      case 'misc':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classified.title!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            Text(
              classified.description!,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
            ),
          ],
        );
      case 'real_estate':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  classified.title!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
                Text(
                  classified.price != null
                      ? formatCurrency.format(double.parse(classified.price!))
                      : '',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconLocationMarketplace.svg(),
                const HorizontalSpace(5),
                Text(
                  classified.location!,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        );
      default:
        return const SizedBox();
    }
  }

  void _initBloc() {
    _classifiedDetailsCubit = BlocProvider.of<ClassifiedDetailsCubit>(context);
  }

  @override
  void initState() {
    _initBloc();
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    try {
      final token = await readStringSharedPref(spProfileJwt);

      final response = await http.get(
        // Uri.parse('$baseUrlDev/classifieds?page=1&id=1'),
        Uri.parse('$baseUrlDev/classifieds?page=1&id=1'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey("data")) {
          var dataList = responseData["data"] as List<dynamic>;

          setState(() {
            classifiedList =
                dataList.map((item) => Classified.fromJson(item)).toList();
            print('Response Data: $responseData');
          });
        } else {
          throw Exception('Invalid response format: "data" key not found');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error gracefully, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: classifiedList.length,
      itemBuilder: (context, index) {
        var classified = classifiedList[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InnerClassified(),
                    ),
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.21,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Image.network(
                      classified.gallery.isNotEmpty
                          ? classified.gallery[1]
                          : 'https://i.pinimg.com/736x/de/f3/8f/def38ffeb9b8d223fce85735fc9c9b50.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    categoryChecker(classified: classified),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            classified.location.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              color: AppColors.lightGrey5,
                            ),
                          ),
                        ),
                        Text(
                          'Listed ${classified.createdAt != null ? getFormattedDate(date: classified.createdAt.toString(), format: 'dd.MM.yyyy') : 'N/A'}',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: AppColors.lightGrey5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
