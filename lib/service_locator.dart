import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/config/constants/api_constants.dart';
import 'package:news_app/features/news/data%20/repositories%20/favorites_news_repository.dart';
import 'package:news_app/features/news/domain/repositories/favorites_news_repository.dart';
import 'package:news_app/features/news/domain/usecases/add_news_usecase.dart';
import 'package:news_app/features/news/domain/usecases/remove_news_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/news/data /data_sources/local_storage_service.dart';
import 'features/news/data /data_sources/news_api_service.dart';
import 'features/news/data /repositories /news_repository_impl.dart';
import 'features/news/domain/repositories/news_repository.dart';
import 'features/news/domain/usecases/get_top_headlines.dart';
import 'features/news/domain/usecases/favorites_usecase.dart';
import 'features/news/domain/usecases/search_news.dart';
import 'features/news/presentation/bloc/news/news_bloc.dart';
import 'features/news/presentation/bloc/favorites/favorites_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  )));

  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerLazySingleton(() => NewsApiService(dio: sl()));
  sl.registerLazySingleton(() => LocalStorageService());

  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
    apiService: sl(),
  ));
  sl.registerLazySingleton<SavedNewsRepository>(() => SavedNewsRepositoryImpl(
      sl()
  ));

  sl.registerLazySingleton(() => GetTopHeadlines(sl()));
  sl.registerLazySingleton(() => SearchNews(sl()));
  sl.registerLazySingleton(() => GetSavedNewsUseCase(sl<SavedNewsRepository>()));
  sl.registerLazySingleton(() => AddNewsUseCase(sl<SavedNewsRepository>()));
  sl.registerLazySingleton(() => RemoveNewsUseCase(sl<SavedNewsRepository>()));


  sl.registerFactory(() => NewsBloc(
    getTopHeadlines: sl(),
    searchNews: sl(),
  ));

  sl.registerFactory(() => FavoritesBloc(
    getSavedNews: sl(),
    addNews: sl(),
    removeNews: sl(),
  ));

}
