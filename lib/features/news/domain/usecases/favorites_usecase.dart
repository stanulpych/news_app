import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/favorites_news_repository.dart';

class GetSavedNewsUseCase {
  final SavedNewsRepository _repository;

  GetSavedNewsUseCase(this._repository);

  Future<List<News>> call() {
    return _repository.getSavedNews();
  }
}