import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFD4AF37);
  static const Color secondary = Color(0xFFB8860B);
  static const Color background = Color(0xFF1A1614);
  static const Color surface = Color(0xFF2A2320);
  static const Color textPrimary = Color(0xFFF5F0E8);
  static const Color textSecondary = Color(0xFFB8B0A8);
  static const Color glassBorder = Color(0x14FFFFFF);
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: textPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textSecondary.withOpacity(0.3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: GoogleFonts.cormorantGaramond(
            fontSize: 32, fontWeight: FontWeight.w500, color: textPrimary),
        titleLarge: GoogleFonts.cormorantGaramond(
            fontSize: 24, fontWeight: FontWeight.w500, color: textPrimary),
        bodyLarge: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w400, color: textPrimary),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w400, color: textSecondary),
        labelSmall: GoogleFonts.inter(
            fontSize: 12, fontWeight: FontWeight.w400, color: textSecondary),
      ),
    );
  }
}
