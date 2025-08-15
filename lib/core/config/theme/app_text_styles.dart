import 'package:flutter/material.dart';
import 'package:news_app/core/config/theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.0, // line-height 100%
    color: AppColors.black,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w700,
    fontSize: 33,
    height: 1.0, // line-height 100%
    color: AppColors.black,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w400,
    fontSize: 19,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w400,
    fontSize: 27,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w400,
    fontSize: 26,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle subtitleDate = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w400,
    fontSize: 17,
    height: 1.0,
    color: AppColors.black,
  );

  static const TextStyle menuItem = TextStyle(
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w400,
    fontSize: 19,
    height: 1.0,
    color: AppColors.black,
    textBaseline: TextBaseline.alphabetic,
  );
}
