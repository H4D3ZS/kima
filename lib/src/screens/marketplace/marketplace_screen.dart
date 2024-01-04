import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/classifieds_model.dart';
import 'package:kima/src/data/models/marketplace.dart';
import 'package:kima/src/data/providers/classified_provider.dart';
import 'package:kima/src/screens/classifieds/classifieds_screen.dart';
import 'package:kima/src/screens/marketplace/widgets/marketplace/classified_item.dart';
import 'package:kima/src/screens/qrcode/qr_code_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/classifieds/classifieds_card_title_price.dart';

import '../../utils/widgets/common/_common.dart';
import 'ClassiFied_ProviderMarketPlace.dart';
import 'widgets/marketplace/marketplace.dart';
import 'package:kima/src/screens/marketplace/classifieds_description_screen.dart';
import 'classifiedItem.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({Key? key}) : super(key: key);

  static const route = '/marketplace';

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  ClassifiedsCategory selectedCategory = ClassifiedsCategory.all;
  List<ClassifiedsCategory> categoryList = ClassifiedsCategory.values.toList();
  List<Marketplace> classifiedList = classifiedsMockList.toList();
  bool isCategoryScrollingInactive = true;

  ClassifiedProvider classifiedProvider = ClassifiedProvider();

  @override
  void initState() {
    super.initState();
  }

  void _search(String searchTerm) {
    searchTerm = searchTerm.toLowerCase();
    setState(() {
      // Update the classifiedList based on the search term
      classifiedList = classifiedsMockList
          .where((market) =>
              market.title.toLowerCase().contains(searchTerm) ||
              market.description.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Possible use of custom appbar to achieve re-usability of widgets on pages with same layout
      appBar: AppBar(
        title: const Text(
          'Marketplace',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 110.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () {
            // Navigator.pop(context);
          },
        ),
        actions: [
          CircularIconButton(
            icon: Assets.icons.iconPlus.svg(),
            bgColor: AppColors.lightGrey20,
            width: 50.0,
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            onTap: () {
              Navigator.pushNamed(
                context,
                ClassifiedsScreen.route,
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _searchController,
                          // autofocus: true,
                          // inputFormatters: <TextInputFormatter>[
                          //   // LengthLimitingTextInputFormatter(Global.searchCharacterLimit),
                          // ],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          // onChanged: onChanged,

                          onChanged: (searchTerm) {
                            _search(searchTerm);
                            setState(() {
                              // Update the classifiedList based on the search term
                              classifiedList = classifiedsMockList
                                  .where((market) =>
                                      market.title
                                          .toLowerCase()
                                          .contains(searchTerm) ||
                                      market.description
                                          .toLowerCase()
                                          .contains(searchTerm))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search something here',
                            hintStyle:
                                const TextStyle(color: AppColors.lightGrey10),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(
                                right: 9.0,
                                bottom: Platform.isIOS ? 14.0 : 13.0),
                            prefixIcon: IconButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13.0, vertical: 15.0),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Assets.icons.iconSearch.svg(),
                                color: Colors.white,
                                onPressed: () {
                                  String searchTerm =
                                      _searchController.text.toLowerCase();

                                  setState(() {
                                    // Update the classifiedList based on the search term
                                    classifiedList = classifiedsMockList
                                        .where((market) =>
                                            market.title
                                                .toLowerCase()
                                                .contains(searchTerm) ||
                                            market.description
                                                .toLowerCase()
                                                .contains(searchTerm))
                                        .toList();
                                  });
                                }),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD9D9D9)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    RoundedSquareIconButton(
                      icon: Assets.icons.iconQrWhite.svg(),
                      padding: const EdgeInsets.only(left: 15.0),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          QRCodeScreen.route,
                          arguments:
                              BlocProvider.of<UserBloc>(context).state.user!,
                        );
                      },
                    ),
                    RoundedSquareIconButton(
                      icon: Assets.icons.iconSliders.svg(),
                      buttonColor: AppColors.green.withOpacity(0.12),
                      padding: const EdgeInsets.only(left: 15.0),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const VerticalSpace(20.0),
              NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  setState(() => isCategoryScrollingInactive =
                      notification.metrics.pixels <= 0);
                  return true;
                },
                child: Container(
                    margin: EdgeInsets.only(
                        left: isCategoryScrollingInactive ? 30.0 : 0.0),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ListView.builder(
                      itemCount: categoryList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final category = categoryList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MarketplaceCategory(
                            type: category,
                            title: category.label,
                            index: index,
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                                isCategoryScrollingInactive = true;

                                if (selectedCategory ==
                                    ClassifiedsCategory.all) {
                                  categoryList =
                                      ClassifiedsCategory.values.toList();
                                  classifiedList = classifiedsMockList.toList();
                                } else {
                                  categoryList = [
                                    ClassifiedsCategory.values.firstWhere(
                                        (value) => value == category),
                                    ClassifiedsCategory.all,
                                  ];
                                  classifiedList = classifiedsMockList
                                      .where((market) =>
                                          market.category == selectedCategory)
                                      .toList();
                                }
                              });
                            },
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [ClassifiedItem()],
          ),
        ),
      ),
    );
  }
}
