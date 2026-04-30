import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final baseText = GoogleFonts.outfitTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF030303),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white70,
        surface: Color(0xFF0A0A0A),
        tertiary: Color(0xFF818CF8),
      ),
      textTheme: baseText.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      useMaterial3: true,
      hoverColor: Colors.white.withValues(alpha: 0.08),
      splashColor: Colors.white.withValues(alpha: 0.05),
    );
  }
}
