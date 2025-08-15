import 'package:news_app/features/news/data%20/data_sources/local_storage_service.dart';
import 'package:news_app/features/news/data%20/models/news_model.dart';
import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/repositories/favorites_news_repository.dart';

class SavedNewsRepositoryImpl implements SavedNewsRepository {
  final LocalStorageService _service;

  SavedNewsRepositoryImpl(this._service);

  @override
  Future<List<News>> getSavedNews() async {
    return await _service.getSavedNews();
  }

  @override
  Future<void> addNews(News news) async {
    await _service.saveNews(NewsModel.fromEntity(news));
  }

  @override
  Future<void> removeNews(News news) async {
    await _service.removeNews(NewsModel.fromEntity(news));
  }
}