import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/app_text_styles.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/core/widgets/custom_botton_nav_bar.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news/news_bloc.dart';
import 'package:news_app/features/news/presentation/widgets%20/news_card.dart';
import 'package:news_app/features/news/presentation/widgets%20/search_bar_widget.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  String _selectedCategory = 'General';
  final List<String> _categories = const [
    'Health',
    'Business',
    'Entertainment',
    'General',
    'Science',
    'Sports',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNews(category: _selectedCategory.toLowerCase()));
    context.read<FavoritesBloc>().add(LoadFavoritesNews());
  }

  void _onCategorySelected(String category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
    });
    context.read<NewsBloc>().add(LoadNews(category: category.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: SearchBarWidget(
            onSearch: (query) {
              if (query.trim().isEmpty) {
                context.read<NewsBloc>().add(LoadNews(category: _selectedCategory.toLowerCase()));
              } else {
                context.read<NewsBloc>().add(SearchNewsEvent(query.trim(), _selectedCategory.toLowerCase()));
              }
            },
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                _buildCategoriesChips(),
                SizedBox(height: 10),
                Expanded(
                  child: _buildNewsList(),
                ),
              ],
            ),
            const Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: CustomBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = category == _selectedCategory;
            return ActionChip(
              label: Text(category),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide.none,
              ),
              backgroundColor: isSelected ? AppColors.mainBlue : AppColors.gray,
              labelStyle: AppTextStyles.body.copyWith(fontSize: 17, color: AppColors.white),
              onPressed: () => _onCategorySelected(category),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, newsState) {
        if (newsState is NewsLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.black));
        } else if (newsState is NewsLoaded) {
          if (newsState.news.isEmpty) {
            return const Center(child: Text('Нет новостей' , style: AppTextStyles.body));
          }
          return BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, favoritesState) {
              if (favoritesState is FavoritesLoaded) {
                final List<String> savedNewsTitles = favoritesState.news.map((n) => n.title!).toList();

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: newsState.news.length,
                  itemBuilder: (context, index) {
                    final news = newsState.news[index];
                    if (news.imageUrl == null || news.imageUrl!.isEmpty || news.title == null || news.title!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    final bool isFavorite = savedNewsTitles.contains(news.title);

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
                      isFavorite: isFavorite,
                      onFavoriteTap: () {
                        if (isFavorite) {
                          context.read<FavoritesBloc>().add(RemoveNewsFromFavorites(news));
                        } else {
                          context.read<FavoritesBloc>().add(AddNewsToFavorites(news));
                        }
                      },
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator(color: AppColors.black));
            },
          );
        } else if (newsState is NewsError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh, size: 45, color: AppColors.black),
                  onPressed: () {
                    context
                        .read<NewsBloc>()
                        .add(LoadNews(category: _selectedCategory.toLowerCase()));
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  newsState.message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}