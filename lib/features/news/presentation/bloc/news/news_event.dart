part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadNews extends NewsEvent {
  final String category;
  LoadNews({this.category = 'general'});
}

class SearchNewsEvent extends NewsEvent {
  final String query;
  final String category;
  SearchNewsEvent(this.query, this.category);
}
