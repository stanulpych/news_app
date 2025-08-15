import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/usecases/add_news_usecase.dart';
import 'package:news_app/features/news/domain/usecases/favorites_usecase.dart';
import 'package:news_app/features/news/domain/usecases/remove_news_usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetSavedNewsUseCase getSavedNews;
  final AddNewsUseCase addNews;
  final RemoveNewsUseCase removeNews;

  FavoritesBloc({
    required this.getSavedNews,
    required this.addNews,
    required this.removeNews,
  }) : super(FavoritesInitial()) {
    on<LoadFavoritesNews>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final news = await getSavedNews();
        emit(FavoritesLoaded(news));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<AddNewsToFavorites>((event, emit) async {
      try {
        await addNews(event.news);
        add(LoadFavoritesNews());
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<RemoveNewsFromFavorites>((event, emit) async {
      try {
        await removeNews(event.news);
        add(LoadFavoritesNews());
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
  }
}