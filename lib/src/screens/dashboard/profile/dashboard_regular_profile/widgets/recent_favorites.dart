import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/widgets/recent_favorite_tile.dart';
import 'package:kima/src/screens/marketplace/marketplace_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RecentFavorites extends StatelessWidget {
  const RecentFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText('Recently Favorites', fontWeight: FontWeight.w500),
            const VerticalSpace(15.0),
            // TODO: if favorites isNotEmpty
            if (1 == 0)
              ...List.generate(3, (index) => const RecentFavoriteTile())
            else
              RichText(
                text: TextSpan(
                  text: 'You don’t have any favorites right now. You can explore ',
                  style: GoogleFonts.poppins(
                    color: AppColors.lightGrey10,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          BlocProvider.of<AppBottomNavCubit>(context).emitBottomNav(BottomNavEnum.market);
                          BlocProvider.of<SwitchViewCubit>(context).selectedRoute(MarketPlaceScreen.route);
                        },
                      text: 'Marketplace.',
                      style: GoogleFonts.poppins(
                        color: AppColors.green,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
}
