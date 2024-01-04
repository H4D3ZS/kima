import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/daily_status_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/dashboard_business_profile_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/edit_daily_status_screen.dart';
import 'package:kima/src/screens/dashboard/profile/edit_bio_screen.dart';
import 'package:kima/src/screens/dashboard/profile/edit_profile_screen.dart';
import 'package:kima/src/screens/dashboard/dashboard_screen.dart';
import 'package:kima/src/screens/dashboard/notifications/notifications_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/dashboard_regular_profile_screen.dart';
import 'package:kima/src/screens/favorites/favorites_screen.dart';
import 'package:kima/src/screens/marketplace/classifieds_description_screen.dart';
import 'package:kima/src/screens/marketplace/marketplace_screen.dart';
import 'package:kima/src/screens/message/working%20chat/conversation_screen.dart';
import 'package:kima/src/screens/profile/about_screen.dart';
import 'package:kima/src/screens/profile/profile_screen.dart';
import 'package:kima/src/screens/report/report_additional_detail_screen.dart';
import 'package:kima/src/screens/report/report_screen.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_screen.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_settings_screen.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/helpers/encryption.dart';
import 'package:uni_links/uni_links.dart';

import '../data/global.dart';
import 'search/search/search_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  static const route = '/root';

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late AppBottomNavCubit _navCubit;
  late SwitchViewCubit _switchViewCubit;

  late StreamSubscription _subscription;

  Future<void> initUniLinks() async {
    _subscription = linkStream.listen((String? link) {
      if (link != null) {
        final uri = Uri.parse(link);
        final idParam = uri.queryParameters['id'];

        if (uri.path.contains('user')) {
          if (idParam != null) {
            final idCipher = Uri.decodeComponent(idParam);
            final id = Encrypt.decrypted(idCipher);

            final loggedInUser = BlocProvider.of<UserBloc>(context).state.user;

            if (id == loggedInUser?.id) {
              _navCubit.emitBottomNav(BottomNavEnum.home);
              _switchViewCubit.selectedRoute(
                  loggedInUser!.isBusinessOrProfessionalUser
                      ? DashboardBusinessProfileScreen.route
                      : DashboardRegularProfileScreen.route);
            } else {
              BlocProvider.of<UserBloc>(context).add(GetUserVisitByIdEvent(id));
              _navCubit.emitBottomNav(BottomNavEnum.search);
              _switchViewCubit.selectedRoute(ProfileVisitScreen.route);
            }
          }
        }
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
    _initBloc();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _initBloc() {
    _navCubit = BlocProvider.of<AppBottomNavCubit>(context);
    _switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);

    /// Load current daily status of the logged in user
    BlocProvider.of<DailyStatusBloc>(context)
        .add(const GetCurrentStatusByIdEvent());

    // _userProfileCubit = BlocProvider.of<AppUserProfileCubit>(context);
    // _userProfileCubit.emitProfileJwt();
  }

  /// Change the state of bottomNav
  void _onItemTapped(int index) {
    _navCubit.emitBottomNav(
      BottomNavEnum.values[index],
    );

    /// Reset the SwitchViewCubit index
    _switchViewCubit.selectedRoute('');
  }

  /// Widget for bottom navigator buttons
  BottomNavigationBarItem _navigationItem({
    required String image,
    required String label,
    required bool selected,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(image),
        size: 20,
        color: selected ? const Color(0xFF7AE2A0) : const Color(0xFFC3C3D1),
      ),
      label: label,
    );
  }

  int _currentIndex(BottomNavEnum nav) {
    return BottomNavEnum.values.indexOf(nav);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavCubit, BottomNavEnum>(
      builder: (context, navState) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: Builder(
            builder: (context) {
              if (navState == BottomNavEnum.home) {
                return BlocBuilder<SwitchViewCubit, String>(
                    builder: (context, route) {
                  if (route == DashboardScreen.route)
                    return const DashboardScreen();
                  if (route == DashboardRegularProfileScreen.route)
                    return const DashboardRegularProfileScreen();
                  if (route == DashboardBusinessProfileScreen.route)
                    return const DashboardBusinessProfileScreen();
                  if (route == EditProfileScreen.route)
                    return const EditProfileScreen();
                  if (route == EditBioScreen.route)
                    return const EditBioScreen();

                  if (route == NotificationsScreen.route)
                    return const NotificationsScreen();

                  // Business/Professional Daily status
                  if (route == EditDailyStatus.route)
                    return const EditDailyStatus();
                  return const DashboardScreen();
                });
              }
              if (navState == BottomNavEnum.search) {
                return BlocBuilder<SwitchViewCubit, String>(
                    builder: (context, route) {
                  if (route == SearchScreen.route) return const SearchScreen();

                  /// User profile visit
                  if (route == ProfileVisitScreen.route)
                    return const ProfileVisitScreen();
                  if (route == ProfileVisitSettingsScreen.route)
                    return const ProfileVisitSettingsScreen();

                  if (route == ReportScreen.route) return const ReportScreen();
                  if (route == ReportAdditionalDetailScreen.route)
                    return const ReportAdditionalDetailScreen();
                  return const SearchScreen();
                });
              }
              if (navState == BottomNavEnum.market) {
                return BlocBuilder<SwitchViewCubit, String>(
                    builder: (context, route) {
                  if (route == MarketPlaceScreen.route) {
                    return const MarketPlaceScreen();
                  } else if (route == ClassifiedsDescriptionScreen.route) {
                    return const ClassifiedsDescriptionScreen();
                  } else if (route == ReportScreen.route) {
                    return const ReportScreen();
                  } else if (route == ReportAdditionalDetailScreen.route) {
                    return const ReportAdditionalDetailScreen();
                  } else {
                    return const MarketPlaceScreen();
                  }
                });
              }
              if (navState == BottomNavEnum.favorite) {
                return BlocBuilder<SwitchViewCubit, String>(
                    builder: (context, route) {
                  if (route == FavoritesScreen.route) {
                    return const FavoritesScreen();
                  } else if (route == ProfileScreen.route) {
                    return ProfileScreen(
                      favoriteModel: Global.favoriteModel,
                    );
                  } else if (route == ProfileVisitSettingsScreen.route) {
                    return const ProfileVisitSettingsScreen();
                  } else if (route == AboutScreen.route) {
                    return const AboutScreen();
                  } else if (route == ReportScreen.route) {
                    return const ReportScreen();
                  } else {
                    return const FavoritesScreen();
                  }
                });

                ///
                // return Navigator(
                //   onGenerateRoute: (settings) {
                //     Widget page = const FavoritesScreen();
                //     if (settings.name == ProfileScreen.route) {
                //       page = ProfileScreen(favoriteModel: Global.favoriteModel,);
                //     } else if (settings.name == ProfileVisitSettingsScreen.route) {
                //       page = const ProfileVisitSettingsScreen();
                //     } else if (settings.name == AboutScreen.route) {
                //       page = const AboutScreen();
                //     } else if (settings.name == ReportScreen.route) {
                //       page = const ReportScreen();
                //     }
                //     return MaterialPageRoute(builder: (_) => page);
                //   },
                // );
              }
              if (navState == BottomNavEnum.message) {
                /// FavoritesScreen
                return const ConversationListScreen();
              }

              /// Default screen
              return const SizedBox();
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex(navState),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              color: Color(0xFF7AE2A0),
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Color(0xFFC3C3D1),
              fontWeight: FontWeight.w400,
              fontSize: 13.0,
            ),
            elevation: 10.0,
            backgroundColor: const Color(0xFFFFFFFF),
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              _navigationItem(
                image: iconPngHome,
                label: 'Home',
                selected: navState == BottomNavEnum.home,
              ),
              _navigationItem(
                image: iconPngSearch,
                label: 'Search',
                selected: navState == BottomNavEnum.search,
              ),
              _navigationItem(
                image: iconPngMarket,
                label: 'Market',
                selected: navState == BottomNavEnum.market,
              ),
              _navigationItem(
                image: iconPngFavorite,
                label: 'Favorite',
                selected: navState == BottomNavEnum.favorite,
              ),
              _navigationItem(
                image: iconPngMessage,
                label: 'Message',
                selected: navState == BottomNavEnum.message,
              ),
            ],
          ),
        );
      },
    );
  }
}
