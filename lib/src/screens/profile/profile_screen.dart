import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

import '../../blocs/common/switch_view_cubit.dart';
import '../../data/models/favorite_model.dart';
import '../../utils/widgets/common/_common.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.favoriteModel,
  });

  final FavoriteModel? favoriteModel;

  static const route = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SwitchViewCubit _switchViewCubit;

  @override
  void initState() {
    super.initState();
    _initBloc();
  }

  void _initBloc() {
    _switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as FavoriteModel;

    return HeaderWrapper(
      onBack: () {},
      // onBack: () => _switchViewCubit.selectedRoute(0),
      titleHeader: '${widget.favoriteModel!.name}\'s Profile',
      actions: [
        CircularIconButton(
          icon: Assets.icons.bottomNavigation.iconFavorite.image(color: Colors.white),
          bgColor: Colors.red,
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 32),
          onTap: () {
          },
        ),
      ],
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.width * 0.50,
                                  color: Colors.black,
                                  child: Image.asset(
                                    // args.image!,
                                    widget.favoriteModel!.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.width * 0.50,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: (MediaQuery.of(context).size.width * 0.50) * 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 120,
                                    width: 120,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                        // args.image!,
                                          widget.favoriteModel!.image!
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.favoriteModel!.name!,
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                          ),
                                        ),
                                        Text(
                                          'Tech Company',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: AppColors.lightGrey10
                                          ),
                                        ),
                                        const VerticalSpace(20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    color: AppColors.primaryColor
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                  child: Text(
                                                    'Follow',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                )
                                              ),
                                              const HorizontalSpace(15),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                    border: Border.all(color: AppColors.primaryColor, width: 1)
                                                  ),
                                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                                  child: Text(
                                                    'Message',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.primaryColor
                                                    ),
                                                  ),
                                                )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    // Navigator.pushNamed(context,
                                                    //   ProfileSettingsScreen.route,
                                                    // );

                                                    /// Next ProfileSettingScreen
                                                    // _switchViewCubit.selectedRoute(2);
                                                  },
                                                  child: const Icon(
                                                    Icons.more_horiz,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 10,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        // args.type == 'company'
                        //     ? _buildWidget2(args)
                        //     : _buildWidget1(args),
                        widget.favoriteModel!.type == 'company'
                            ? _buildWidget2(widget.favoriteModel!)
                            : _buildWidget1(widget.favoriteModel!),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidget1(FavoriteModel favoriteModel) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${favoriteModel.name}\'s Activity',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          favoriteModel.image!,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favoriteModel.name!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Text(
                              '15 hours ago',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      const Icon(
                        Icons.more_horiz,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidget2(FavoriteModel favoriteModel) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(15),
                Text(
                  'Daily Status',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                ),
                const VerticalSpace(10),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 0.0, 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/temporary/daily-status-bg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const CustomText(
                    'Moving mountains together. #KIMAAPP',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.lightGrey10,
                  ),
                ),
                const VerticalSpace(15)
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.grey.withOpacity(0.2),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Social Media',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                ),
                const VerticalSpace(10),
                Row(
                  children: [
                    Assets.icons.iconSocialMedia.svg(),
                    const HorizontalSpace(10),
                    Assets.icons.iconSocialMedia.svg()
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.grey.withOpacity(0.2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  '${favoriteModel.name}\'s Feed',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          favoriteModel.image!,
                        ),
                      ),
                    ),
                    const HorizontalSpace(15),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            favoriteModel.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(width: 10,),
                          const Text(
                            '1w',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const HorizontalSpace(15),
                    IconWithCircleButton(
                      iconData: Icons.more_vert,
                      bgColor: Colors.transparent,
                      iconColor: Colors.black,
                      onTap: () {}
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.50,
                color: Colors.black,
                child: Image.asset(
                  favoriteModel.image!,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mount Everest Day',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: AppColors.primaryColor
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'View Details',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                              ),
                            ),
                          )
                        ),
                        const HorizontalSpace(15),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: AppColors.primaryColor, width: 1)
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Message User',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
