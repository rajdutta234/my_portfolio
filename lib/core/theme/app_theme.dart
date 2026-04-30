import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final baseText = GoogleFonts.montserratTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF050505),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFFC5C5C5),
        surface: Color(0xFF0F0F0F),
        tertiary: Color(0xFF6366F1),
      ),
      textTheme: baseText.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      useMaterial3: true,
      hoverColor: Colors.white.withValues(alpha: 0.12),
      splashColor: Colors.white.withValues(alpha: 0.08),
      highlightColor: Colors.white.withValues(alpha: 0.05),
    );
  }
}
