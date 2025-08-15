import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/assets.dart';
import 'package:news_app/core/routes/app_routes.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == AppRoutes.newsListPath) return 0;
    if (location == AppRoutes.favoritesPath) return 1;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return Container(
      height: 84,
      width: 322,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => context.goNamed(AppRoutes.newsList),
            child: SvgPicture.asset(
              AppAssets.menu1,
              height: 28,
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? AppColors.mainBlue : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.goNamed(AppRoutes.favorites),
            child: SvgPicture.asset(
              AppAssets.menu2,
              height: 28,
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? AppColors.mainBlue : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
