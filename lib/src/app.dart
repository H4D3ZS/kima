import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/app_route.dart';
import 'package:kima/src/app_theme.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/app_flavor_cubit.dart';
import 'package:kima/src/blocs/common/app_version_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/chat/chat_details_cubit.dart';
import 'package:kima/src/blocs/main/classifieds/classified_details_cubit.dart';
import 'package:kima/src/blocs/main/classifieds/classifieds_bloc.dart';
import 'package:kima/src/blocs/main/feed/feed_bloc.dart';
import 'package:kima/src/blocs/main/marketplace/marketplace_cubit.dart';
import 'package:kima/src/blocs/main/report/report_bloc.dart';
import 'package:kima/src/blocs/main/report/report_cubit.dart';
import 'package:kima/src/blocs/main/search_community/community_bloc.dart';
import 'package:kima/src/blocs/main/user/daily_status_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/blocs/main/user/user_favorite_bloc.dart';
import 'package:kima/src/screens/authentication/login/login_screen.dart';
import 'package:kima/src/utils/enums.dart';

class App extends StatefulWidget {
  final AppFlavorsEnum flavor;

  const App({
    super.key,
    required this.flavor,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppFlavorCubit _flavorCubit;
  late AppVersionCubit _versionCubit;
  late AppBottomNavCubit _bottomNavCubit;
  late SwitchViewCubit _switchViewCubit;
  late ReportListCubit _reportListCubit;
  late MarketplaceCubit _marketplaceCubit;
  late ChatDetailsCubit _chatDetailsCubit;

  late UserBloc _userBloc;
  late CommunityBloc _communityBloc;
  late DailyStatusBloc _dailyStatusBloc;
  late FeedBloc _feedBloc;
  late UserFavoriteBloc _userFavoriteBloc;
  late ClassifiedsBloc _classifiedsBloc;
  late ReportBloc _reportBloc;
  late ClassifiedDetailsCubit _classifiedDetailsCubit;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  void _initBloc() {
    _flavorCubit = AppFlavorCubit();
    _flavorCubit.emitFlavor(widget.flavor);

    _versionCubit = AppVersionCubit(flavor: widget.flavor);
    _versionCubit.emitVersion();

    _bottomNavCubit = AppBottomNavCubit();

    _switchViewCubit = SwitchViewCubit();

    _reportListCubit = ReportListCubit();

    _marketplaceCubit = MarketplaceCubit();

    _userBloc = UserBloc();

    _communityBloc = CommunityBloc();

    _dailyStatusBloc = DailyStatusBloc();

    _feedBloc = FeedBloc();

    _userFavoriteBloc = UserFavoriteBloc();

    _classifiedsBloc = ClassifiedsBloc();

    _reportBloc = ReportBloc();

    _classifiedDetailsCubit = ClassifiedDetailsCubit();

    _chatDetailsCubit = ChatDetailsCubit();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _flavorCubit,
        ),
        BlocProvider(
          create: (context) => _versionCubit,
        ),
        BlocProvider(
          create: (context) => _bottomNavCubit,
        ),
        BlocProvider(
          create: (context) => _switchViewCubit,
        ),
        BlocProvider(
          create: (context) => _reportListCubit,
        ),
        BlocProvider(
          create: (context) => _marketplaceCubit,
        ),
        BlocProvider(
          create: (context) => _userBloc,
        ),
        BlocProvider(
          create: (context) => _classifiedDetailsCubit,
        ),
        BlocProvider(
          create: (context) => _communityBloc,
        ),
        BlocProvider(
          create: (context) => _chatDetailsCubit,
        ),
        BlocProvider(
          create: (context) => _dailyStatusBloc,
        ),
        BlocProvider(
          create: (context) => _feedBloc,
        ),
        BlocProvider(
          create: (context) => _userFavoriteBloc,
        ),
        BlocProvider(
          create: (context) => _classifiedsBloc,
        ),
        BlocProvider(
          create: (context) => _reportBloc,
        ),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: ClassifiedsDescriptionScreen.route,
          onGenerateRoute: AppRoute.generateRoute,
          theme: AppThemeData.lightThemeData,
        ),

      ),
    );
  }
}
