import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that defines the theme data used in the app.
class AppThemeData {

  static MaterialColor materialColor(Color color) {
    Map<int, Color> colorMap = {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    };

    return MaterialColor(color.value, colorMap);
  }

  /// Defines the color scheme used in the theme.
  static final _colorScheme = ColorScheme.fromSwatch(
    primarySwatch: materialColor(const Color(0xFF38CC96)),
    accentColor: Colors.green,
  );

  /// The light theme data.
  static final lightThemeData = ThemeData(
    useMaterial3: false,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  /// The dark theme data.
  static final darkThemeData = ThemeData(
    colorScheme: _colorScheme.copyWith(
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}

