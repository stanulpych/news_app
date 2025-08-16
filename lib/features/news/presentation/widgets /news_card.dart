import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/config/theme/app_colors.dart';
import 'package:news_app/core/config/theme/app_text_styles.dart';
import 'package:news_app/core/config/theme/assets.dart';
import 'package:news_app/features/news/domain/entities/news.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String date;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final News? news;
  final bool? isNeedShowStar;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.onTap,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.news,
    this.isNeedShowStar
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 322,
        height: 112,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    width: 123,
                    height: 112,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: 123,
                        height: 112,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                            color: AppColors.black,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        width: 123,
                        height: 112,
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 44, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppTextStyles.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 12,
              right: 8,
              child: Text(
                date,
                style: AppTextStyles.subtitleDate,
              ),
            ),
            if(isNeedShowStar != null && isNeedShowStar!)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onFavoriteTap ?? () {},
                child: SvgPicture.asset(
                  AppAssets.star1,
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    AppColors.darkGray,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}