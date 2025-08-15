import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/favorites_news_repository.dart';


class RemoveNewsUseCase {
  final SavedNewsRepository _repository;

  RemoveNewsUseCase(this._repository);

  Future<void> call(News news) {
    return _repository.removeNews(news);
  }
}