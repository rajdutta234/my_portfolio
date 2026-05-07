import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final TextTheme baseText = GoogleFonts.spaceGroteskTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF04080F),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF56F3D6),
        secondary: Color(0xFF8CA6C7),
        surface: Color(0xFF0C1422),
        tertiary: Color(0xFF00C2FF),
        onSurface: Colors.white,
        outline: Color(0xFF2B3A52),
      ),
      textTheme: baseText.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      useMaterial3: true,
      dividerColor: const Color(0xFF223047),
      hoverColor: Colors.white.withValues(alpha: 0.06),
      splashColor: Colors.white.withValues(alpha: 0.02),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
