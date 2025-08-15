import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/domain/entities/news.dart';
import 'package:news_app/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadlines getTopHeadlines;
  final SearchNews searchNews;

  NewsBloc({required this.getTopHeadlines, required this.searchNews}) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await getTopHeadlines(category: event.category);
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError('Ошибка загрузки новостей'));
      }
    });

    on<SearchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await searchNews(event.query, event.category);
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError('Ошибка поиска новостей'));
      }
    });
  }
}
