import 'package:news_app/features/news/data%20/data_sources/news_api_service.dart';
import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService apiService;

  NewsRepositoryImpl({required this.apiService});

  @override
  Future<List<News>> getTopHeadlines({String category = 'general'}) async {
    try {
      final news = await apiService.fetchTopHeadlines(category: category);
      return news;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<News>> searchNews(String query, String category) async {
    try {
      final news = await apiService.fetchTopHeadlines(query: query, category: category);
      return news;
    } catch (e) {
      rethrow;
    }
  }
}
