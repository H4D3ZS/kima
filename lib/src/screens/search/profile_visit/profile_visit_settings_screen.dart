import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/report/report_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/blocs/main/user/user_favorite_bloc.dart';
import 'package:kima/src/screens/qrcode/qr_code_screen.dart';
import 'package:kima/src/screens/report/report_screen.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_about_user_screen.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/circular_icon_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

import '../../../blocs/common/switch_view_cubit.dart';
import '../../../data/models/profile_settings.dart';
import '../../../utils/widgets/common/_common.dart';

class ProfileVisitSettingsScreen extends StatefulWidget {
  const ProfileVisitSettingsScreen({super.key});

  static const route = '/profile-visit/settings';

  @override
  State<ProfileVisitSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileVisitSettingsScreen> with DialogMixins {
  late SwitchViewCubit _switchViewCubit;

  final List<ProfileSettings> _settingsList = <ProfileSettings>[
    ProfileSettings(iconData: Icons.info_outline, title: 'About this user'),
    ProfileSettings(iconData: Icons.report_gmailerrorred, title: 'Report User'),
    ProfileSettings(iconData: Icons.cancel_outlined, title: 'Remove user from favorites'),
    ProfileSettings(iconData: Icons.qr_code, title: 'Create QR code'),
    ProfileSettings(iconData: Icons.more_horiz, title: 'Share via...'),
  ];

  bool _isSelectedUnFollow = false;
  bool _isSelectedDefault = true;
  bool _isSelectedFavorites = false;

  @override
  void initState() {
    super.initState();
    _initBloc();
  }

  void _initBloc() {
    _switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: [
                  SafeArea(
                    bottom: true,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 5, bottom: 16),
                                      width: 50,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                    ),
                                    const Text(
                                      'In your news feed',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildNewsfeed(
                                          title: 'Unfollow',
                                          image: _isSelectedUnFollow
                                              ? 'assets/svg/svg_phone_unfollow.svg'
                                              : 'assets/svg/svg_phone_unselected.svg',
                                          isSelected: _isSelectedUnFollow,
                                          onTap: () {
                                            setState(() {
                                              _isSelectedUnFollow = true;
                                              _isSelectedDefault = false;
                                              _isSelectedFavorites = false;
                                            });
                                          },
                                        ),
                                        _buildNewsfeed(
                                          title: 'Default',
                                          image: _isSelectedDefault
                                              ? 'assets/svg/svg_phone_default.svg'
                                              : 'assets/svg/svg_phone_unselected.svg',
                                          isSelected: _isSelectedDefault,
                                          onTap: () {
                                            setState(() {
                                              _isSelectedUnFollow = false;
                                              _isSelectedDefault = true;
                                              _isSelectedFavorites = false;
                                            });
                                          },
                                        ),
                                        _buildNewsfeed(
                                          title: 'Favorites',
                                          image: _isSelectedFavorites
                                              ? 'assets/svg/svg_phone_favorites.svg'
                                              : 'assets/svg/svg_phone_unselected.svg',
                                          isSelected: _isSelectedFavorites,
                                          onTap: () {
                                            setState(() {
                                              _isSelectedUnFollow = false;
                                              _isSelectedDefault = false;
                                              _isSelectedFavorites = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  'You\'ll see their post in their usual order.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNewsfeed({
    required String title,
    required String image,
    bool isSelected = false,
    Function? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: InkWell(
        onTap: onTap as void Function(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor.withOpacity(0.3) : Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBarNormal(String message, BuildContext context) {
    final SnackBar snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 3),
      action: null,
      backgroundColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'Profile Settings',
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: const Color(0xFFC3C3D1).withOpacity(0.25),
        centerTitle: true,
        toolbarHeight: 110.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => _switchViewCubit.selectedRoute(ProfileVisitScreen.route),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15.0),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _settingsList.length,
              itemBuilder: (BuildContext context, int index) {
                ProfileSettings item = _settingsList[index];
                final user = BlocProvider.of<UserBloc>(context).state.userVisit;

                return !BlocProvider.of<UserFavoriteBloc>(context).state.isFavoriteUser(user!.id!) && index == 2
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (index == 0) {
                              Navigator.pushNamed(context, ProfileVisitAboutUserScreen.route);
                            } else if (index == 1) {
                              BlocProvider.of<ReportBloc>(context).add(const ReportTypeEvent(ReportType.user));
                              _switchViewCubit.selectedRoute(ReportScreen.route);
                            } else if (index == 2) {
                              setState(() {
                                _isSelectedUnFollow = false;
                                _isSelectedDefault = true;
                                _isSelectedFavorites = false;
                              });
                              // _showBottomSheet();
                            } else if (index == 3) {
                              Navigator.pushNamed(
                                context,
                                QRCodeScreen.route,
                                arguments: user,
                              );
                            } else if (index == 4) {
                              showShareModalBottomSheet(context, user);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                item.iconData,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  item.title!,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
