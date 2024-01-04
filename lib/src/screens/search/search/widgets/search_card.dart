import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class SearchCard extends StatelessWidget {
  final UserProfile user;

  const SearchCard(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(vertical: 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrey40),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: 110,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: user.avatar != null
                          ? Image.network(
                              user.avatar!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const SizedBox(),
                              loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CustomText(
                              user.firstName![0].toUpperCase(),
                              fontSize: 50.0,
                              fontColor: Colors.white,
                            )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<UserBloc>(context).add(SetUserVisitEvent(user));
                              BlocProvider.of<AppBottomNavCubit>(context).emitBottomNav(BottomNavEnum.search);
                              BlocProvider.of<SwitchViewCubit>(context).selectedRoute(ProfileVisitScreen.route);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.displayName,
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  // TODO: Remove user type. User type is used temporarily for null job title/location
                                  (user.isProfessionalUser ? user.jobTitle : user.location) ?? user.type!.toTitleCase(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Assets.icons.iconHeart.svg(),
                              const HorizontalSpace(5),
                              // TODO: Get total count of favorites
                              Text(
                                '1050 Favorites',
                                style: GoogleFonts.poppins(fontSize: 12.0, color: AppColors.lightGrey10),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CircularIconButton(
                      borderWidth: 2,
                      borderColor: AppColors.lightGrey40,
                      icon: Assets.icons.iconHeartOutlined.svg(),
                      bgColor: Colors.transparent,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            )),
      );
}
