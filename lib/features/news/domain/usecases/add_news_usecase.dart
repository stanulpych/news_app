import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/favorites_news_repository.dart';

class AddNewsUseCase {
  final SavedNewsRepository _repository;

  AddNewsUseCase(this._repository);

  Future<void> call(News news) {
    return _repository.addNews(news);
  }
}