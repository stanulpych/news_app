import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/features/news/data%20/models/news_model.dart';
import 'package:news_app/features/news/presentation/pages/favorites_page.dart';
import 'package:news_app/features/news/presentation/pages/news_detail_page.dart';
import 'package:news_app/features/news/presentation/pages/news_list_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.newsListPath,
  routes: [
    GoRoute(
      path: AppRoutes.newsListPath,
      name: AppRoutes.newsList,
      builder: (context, state) => const NewsListPage(),
    ),
    GoRoute(
      path: AppRoutes.favoritesPath,
      name: AppRoutes.favorites,
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      path: AppRoutes.newsDetailPath,
      name: AppRoutes.newsDetail,
      builder: (context, state) {
        final news = state.extra as NewsModel?;
        if (news == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).goNamed(AppRoutes.newsList);
          });
          return const SizedBox();
        }
        return NewsDetailPage(news: news);
      },
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Страница не найдена')),
  ),
);


extension GoRouterHelper on BuildContext {
  void goTo(String name, {Object? extra}) {
    GoRouter.of(this).goNamed(name, extra: extra);
  }
}
