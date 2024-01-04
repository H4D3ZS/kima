import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/marketplace/marketplace_cubit.dart';
import 'package:kima/src/data/models/marketplace.dart';
import 'package:kima/src/screens/marketplace/widgets/marketplace/marketplace.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/classifieds/classifieds_card_location_listing.dart';
import 'package:kima/src/utils/widgets/classifieds/classifieds_card_title_price.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class MarketplaceCard extends StatelessWidget {
  MarketplaceCard(
    this.title,
    this.classifiedAd,
    {Key? key}
  ) : super(key: key);

  final Marketplace classifiedAd;
  String? title;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => BlocProvider.of<MarketplaceCubit>(context).select(context, classifiedAd),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.21,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Image.asset('assets/temporary/img_temp_3.png', fit: BoxFit.cover),
                  ),
                ),
                const VerticalSpace(16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ClassifiedsCardTitlePrice(
                        classifiedAd.title,
                        'Free'
                        // classifiedAd.price,
                        // isMonthlyPayment: classifiedAd.category == ClassifiedsCategoryEnum.realStates,
                      ),
                      const VerticalSpace(10.0),
                      Row(
                        children: classifiedAd.cardIconDetails.entries
                            .map((detail) => MarketplaceCardItemDetail(
                                  label: detail.value.toString(),
                                  icon: IconMap.classifiedCardDetails[detail.key],
                                ))
                            .toList(),
                      ),
                      const VerticalSpace(10.0),
                      const Divider(
                        height: 1,
                        color: AppColors.lightGrey5,
                      ),
                    ],
                  ),
                ),
                const VerticalSpace(10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClassifiedsCardLocationListing(classifiedAd.location, classifiedAd.listingDate),
                ),
                const VerticalSpace(6.0),
              ],
            ),
          ),
        ),
      );
}
