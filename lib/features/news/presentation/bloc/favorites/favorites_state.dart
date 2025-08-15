part of 'favorites_bloc.dart';

abstract class FavoritesState {}
class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}
class FavoritesLoaded extends FavoritesState {
  final List<News> news;
  FavoritesLoaded(this.news);
}
class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}