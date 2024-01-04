import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/classified_ad/classified_ad_photo_grid.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/classifieds/classifieds_card_location_listing.dart';
import 'package:kima/src/utils/widgets/classifieds/classifieds_card_title_price.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';

class ClassifiedAdPost extends StatelessWidget {
  const ClassifiedAdPost({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final isDashboardScreen = BlocProvider.of<SwitchViewCubit>(context).state == 0 &&
        BlocProvider.of<AppBottomNavCubit>(context).state == BottomNavEnum.home;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (images.isNotNullNorEmpty) ClassifiedAdPhotoGrid(imageUrls: images),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Column(
            children: [
              const ClassifiedsCardTitlePrice('Nepali Devastation Fundraiser', 'Free'),
              const VerticalSpace(3.0),
              const ClassifiedsCardLocationListing('74th St. Jackson Heights, NY', '09.05.2024'),
              const VerticalSpace(15.0),
              Row(
                children: [
                  Expanded(
                    child: CustomButton.green(
                      label: 'View Details',
                      onPressed: () {},
                      height: 40.0,
                      fontSize: 16.0,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                  const HorizontalSpace(10.0),
                  Expanded(
                    child: CustomButton.white(
                      label: isDashboardScreen ? 'Message User' : 'Edit Details',
                      onPressed: () {},
                      height: 40.0,
                      fontSize: 16.0,
                      labelColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
