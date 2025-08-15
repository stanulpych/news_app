import 'package:news_app/features/news/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getTopHeadlines({String category = 'general'});
  Future<List<News>> searchNews(String query, String category);
}
