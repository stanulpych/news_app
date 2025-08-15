part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}
class LoadFavoritesNews extends FavoritesEvent {}
class AddNewsToFavorites extends FavoritesEvent {
final News news;
AddNewsToFavorites(this.news);
}
class RemoveNewsFromFavorites extends FavoritesEvent {
final News news;
RemoveNewsFromFavorites(this.news);
}
