import 'package:double_v_partners_tt/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Segoe',
    );
  }

  static ThemeData get lightTheme {
    return _buildTheme(
      const ColorScheme.light().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        onSurface: Colors.black87,
        onPrimary: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      const ColorScheme.dark().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surface: Colors.grey[800],
        onSurface: Colors.white70,
        onPrimary: Colors.white,
      ),
    );
  }
}
