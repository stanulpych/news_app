import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/app_text_styles.dart';
import 'package:news_app/core/config/theme/assets.dart';
import 'package:news_app/core/utils/date_formatter.dart';
import 'package:news_app/core/widgets/custom_botton_nav_bar.dart';
import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/presentation/bloc/favorites/favorites_bloc.dart';

class NewsDetailPage extends StatelessWidget {
  final News? news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    if (news == null) {
      return Center(
        child: Text(
          'Новость не найдена',
          style: AppTextStyles.title,
        ),
      );
    }

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favoritesState) {
        bool isFavorite = false;
        if (favoritesState is FavoritesLoaded) {
          isFavorite = favoritesState.news
              .any((element) => element.title == news!.title);
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                AppAssets.back,
                width: 30,
                height: 30,
              ),
              onPressed: () => context.pop(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    if (isFavorite) {
                      context
                          .read<FavoritesBloc>()
                          .add(RemoveNewsFromFavorites(news!));
                    } else {
                      context
                          .read<FavoritesBloc>()
                          .add(AddNewsToFavorites(news!));
                    }
                  },
                  child: SvgPicture.asset(
                    isFavorite ? AppAssets.star1 : AppAssets.star,
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      AppColors.darkGray,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                  child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news!.title ?? '',
                      style: AppTextStyles.title2,
                    ),
                    const SizedBox(height: 16),
                    if (news!.description != null)
                      Text(
                        news!.description!,
                        style: AppTextStyles.subtitle2,
                      ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          news!.source ?? 'Источник',
                          style: AppTextStyles.subtitleDate,
                        ),
                        Text(
                          news!.date != null
                              ? AppDateFormatter.formatMmDdYyyy(news!.date)
                              : '',
                          style: AppTextStyles.subtitleDate,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: (news!.imageUrl != null &&
                              news!.imageUrl!.isNotEmpty)
                          ? Image.network(
                              news!.imageUrl ?? '',
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 220,
                                  color: Colors.grey[300],
                                  child:
                                      const Icon(Icons.broken_image, size: 48),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return SizedBox(
                                  width: double.infinity,
                                  height: 220,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            )
                          : Container(
                              width: double.infinity,
                              height: 220,
                              color: AppColors.gray,
                              child: const Icon(Icons.image_not_supported,
                                  size: 48),
                            ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      news!.text.replaceAll(RegExp(r'<[^>]*>'), ''),
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              )),
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: const CustomBottomNavBar(),
              ),
            ],
          ),
        );
      },
    );
  }
}
