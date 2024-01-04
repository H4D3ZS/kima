import 'package:kima/src/utils/enums.dart';

/// TODO: Check the flavor before build
const AppFlavorsEnum flavor = AppFlavorsEnum.dev;

/// API
// const String baseUrlDev = 'https://kima-api.pareainc.com';

// const String baseUrlDev = 'http://localhost:5000';
const String baseUrlDev = 'https://api.kimaapp.com';
const String baseUrlStg = '';
const String baseUrlProd = '';

// Endpoint
const String endpointLogin = '/login';

/// SharedPrefs
const String spProfileJwt = 'profile-jwt';

/// Assets
// Paths
const String _imagePath = 'assets/icons';
const String _authenticationPath = '$_imagePath/authentication';
const String _bottomNavigationPath = '$_imagePath/bottom_navigation';

// Common
const String logoPngKima = '$_imagePath/launcher_icon.png';

// Authentication
const String iconPngApple = '$_authenticationPath/icon-apple.png';
const String iconPngFacebook = '$_authenticationPath/icon-facebook.png';
const String iconPngGoogle = '$_authenticationPath/icon-google.png';
const String logoPngKimaTitle = '$_authenticationPath/logo-kima-title.png';

// Bottom Navigation
const String iconPngHome = '$_bottomNavigationPath/icon-home.png';
const String iconPngSearch = '$_bottomNavigationPath/icon-search.png';
const String iconPngMarket = '$_bottomNavigationPath/icon-market.png';
const String iconPngFavorite = '$_bottomNavigationPath/icon-favorite.png';
const String iconPngMessage = '$_bottomNavigationPath/icon-message.png';
