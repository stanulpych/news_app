import 'package:flutter/material.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/app_text_styles.dart';


class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Основные цвета
      primaryColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      canvasColor: AppColors.white,
      hintColor: AppColors.gray,
      splashColor: AppColors.white.withOpacity(0.1),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.title2,
        iconTheme: IconThemeData(color: AppColors.black),
      ),

      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.mainBlue,
        unselectedItemColor: AppColors.gray,
        selectedLabelStyle: AppTextStyles.menuItem,
        unselectedLabelStyle: AppTextStyles.menuItem,
        showUnselectedLabels: true,
      ),

    );
  }
}
