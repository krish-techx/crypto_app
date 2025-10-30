import 'package:crypto_app/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.background,
      showDragHandle: true,
      dragHandleColor: AppColors.surface,
    ),
  );
}
