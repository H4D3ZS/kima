import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/marketplace/marketplace_cubit.dart';
import 'package:kima/src/blocs/main/report/report_bloc.dart';
import 'package:kima/src/screens/marketplace/marketplace_screen.dart';
import 'package:kima/src/screens/report/report_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_carousel_indicator/custom_carousel_indicator.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

import 'widgets/classifieds_description/classifieds_description.dart';

class ClassifiedsDescriptionScreen extends StatelessWidget {
  const ClassifiedsDescriptionScreen({Key? key}) : super(key: key);


  static const route = '/marketplace/classifieds-description';

  @override
  Widget build(BuildContext context) {
    final classifiedAd = BlocProvider.of<MarketplaceCubit>(context).state;
    final switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Description',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.1,
        toolbarHeight: 95.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => switchViewCubit.selectedRoute(MarketPlaceScreen.route),
        ),
        actions: [
          CircularIconButton(
            icon: Assets.icons.moreVertical.svg(),
            bgColor: AppColors.lightGrey20,
            width: 50.0,
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            onTap: () {
              BlocProvider.of<ReportBloc>(context).add(const ReportTypeEvent(ReportType.classifieds));
              switchViewCubit.selectedRoute(ReportScreen.route);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClassifiedsHeader(
              category: classifiedAd!.category.name,
              title: classifiedAd.title,
              subtitle: classifiedAd.category == ClassifiedsCategory.for_sale ? classifiedAd.price : null,
              author: classifiedAd.user.displayName,
              listingDate: classifiedAd.listingDate,
            ),
            CustomCarouselIndicator(
              height: 300.0,
              children: classifiedAd.images
                  .map((img) => Image.asset(
                        img,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClassifiedsUserFavorite(
                    user: classifiedAd.user.displayName,
                    joinedDate: '2023',
                    avatar: classifiedAd.user.avatar,
                  ),
                  const VerticalSpace(20.0),
                  const ClassifiedsMessageBox(),
                  if (classifiedAd.description.isNotEmpty == true) ClassifiedsDescriptionBox(classifiedAd.description),
                  if (classifiedAd.tabulatedDetails.isNotEmpty) ...[
                    const VerticalSpace(30.0),
                    const CustomText(
                      'Additional Details',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    const VerticalSpace(15.0),
                    ...classifiedAd.tabulatedDetails.entries.map((detail) => ClassifiedsItemDetail(
                          label: detail.key.toTitleCase(),
                          value: detail.value,
                        ))
                  ],
                  if (classifiedAd.category == ClassifiedsCategory.job_posting) ...[
                    if (classifiedAd.minimumQualifications.isNotNullNorEmpty) ...[
                      const VerticalSpace(30.0),
                      const CustomText(
                        'Minimum Qualifications',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      const VerticalSpace(15.0),
                      ...classifiedAd.bulletedJobDetails[Keys.minimumQualifications].map((text) => BulletText(text)),
                    ],
                    if (classifiedAd.jobDescription.isNotNullNorEmpty) ...[
                      const VerticalSpace(30.0),
                      const CustomText(
                        'Job Description',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      const VerticalSpace(15.0),
                      ...classifiedAd.bulletedJobDetails[Keys.jobDescription].map((text) => BulletText(text)),
                    ],
                  ],
                  if (classifiedAd.category == ClassifiedsCategory.events &&
                      classifiedAd.tickets.isNotNullNorEmpty) ...[
                    const VerticalSpace(30.0),
                    const CustomText(
                      'Ticket Prices',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    const VerticalSpace(15.0),
                    ...classifiedAd.tickets!.sortPriceLowToHigh.map(
                      (ticket) => ClassifiedsItemDetail(
                        label: ticket.title,
                        value: ticket.price,
                      ),
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
