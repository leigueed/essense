import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFe7ddd3);
  static const Color secondary = Color(0xFF29251c);
  static const Color background = Color(0xFFc0c2bd);
  static const Color surface = Color(0xFF9c9994);
  static const Color textPrimary = Color(0xFFFfffff);
  static const Color textSecondary = Color(0xFF000000);
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
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary.withValues(alpha: 0.5)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textSecondary.withValues(alpha: 0.2)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: GoogleFonts.inter(
            fontSize: 27, fontWeight: FontWeight.w500, color: textPrimary),
        titleLarge: GoogleFonts.inter(
            fontSize: 22, fontWeight: FontWeight.w500, color: textPrimary),
        bodyLarge: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w400, color: textPrimary),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w300, color: textSecondary),
        labelSmall: GoogleFonts.inter(
            fontSize: 13, fontWeight: FontWeight.w500, color: textSecondary),
      ),
    );
  }
}
