import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/config/theme/app_theme.dart';
import 'package:news_app/core/routes/app_router.dart';
import 'package:news_app/service_locator.dart' as di;
import 'features/news/presentation/bloc/news/news_bloc.dart';
import 'features/news/presentation/bloc/favorites/favorites_bloc.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (_) => di.sl<NewsBloc>(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => di.sl<FavoritesBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
