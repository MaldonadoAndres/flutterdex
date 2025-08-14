part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class FilteredFavorites extends FavoritesEvent {
  const FilteredFavorites(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}
