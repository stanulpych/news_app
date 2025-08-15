import 'package:news_app/features/news/domain/entities/news.dart';

abstract class SavedNewsRepository {
  Future<List<News>> getSavedNews();
  Future<void> addNews(News news);
  Future<void> removeNews(News news);
}
