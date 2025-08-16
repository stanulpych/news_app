import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/app_text_styles.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/core/widgets/custom_botton_nav_bar.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/widgets%20/news_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.black));
              } else if (state is FavoritesLoaded) {
                if (state.news.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100),
                      child: Text(
                        'У вас пока нет сохраненных новостей. Добавьте их, нажав на звёздочку!',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 80, bottom: 100),
                  itemCount: state.news.length,
                  itemBuilder: (context, index) {
                    final news = state.news[index];
                    return NewsCard(
                      news: news,
                      imageUrl: news.imageUrl!,
                      title: news.title!,
                      subtitle: news.description ?? '',
                      date: AppDateFormatter.formatMmDdYyyy(news.date),
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.newsDetail,
                          extra: news,
                        );
                      },
                      isFavorite: true,
                      onFavoriteTap: () {
                        context.read<FavoritesBloc>().add(RemoveNewsFromFavorites(news));
                      },
                    );
                  },
                );
              } else if (state is FavoritesError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: const CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }


}
