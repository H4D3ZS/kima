import 'package:flutter/material.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/common/circular_avatar_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class DashboardFavorites extends StatelessWidget {
  final Function() onSeeMorePressed;

  const DashboardFavorites({
    super.key,
    required this.onSeeMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    MemberProvider memberProvider = MemberProvider();
    const imageList = [
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_3.png',
      'assets/temporary/img_temp_1.png',
      'assets/temporary/img_temp_2.jpeg',
      'assets/temporary/img_temp_2.jpeg',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.lightGrey20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  'Your Favorites',
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  'See More',
                  fontColor: AppColors.lightGrey10,
                  fontWeight: FontWeight.w500,
                  onPressed: onSeeMorePressed,
                ),
              ],
            ),
          ),
          const VerticalSpace(20.0),
          SizedBox(
            height: 50.0,
            child: FutureBuilder(
              future: memberProvider.getFavorites(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      ListView.separated(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        separatorBuilder: (_, index) => const HorizontalSpace(14.0),
                        itemBuilder: (_, index) => CircularAvatarButton(
                          onTap: () {},
                          image: 'assets/temporary/img_temp_1.png',
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  // return Text('${snapshot.error}');
                  return const Center(child: Text('No favorites'),);
                }
                return const SizedBox();
              }
            )
          ),
        ],
      ),
    );
  }
}
