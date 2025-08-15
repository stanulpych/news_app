import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class SearchNews {
  final NewsRepository repository;
  SearchNews(this.repository);

  Future<List<News>> call(String query, String category) async {
    return repository.searchNews(query, category);
  }
}