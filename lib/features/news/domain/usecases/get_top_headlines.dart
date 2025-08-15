import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetTopHeadlines {
  final NewsRepository repository;
  GetTopHeadlines(this.repository);

  Future<List<News>> call({String category = 'general'}) async {
    return repository.getTopHeadlines(category: category);
  }
}