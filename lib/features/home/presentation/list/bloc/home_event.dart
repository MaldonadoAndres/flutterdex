part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadPokemons extends HomeEvent {}

class HomeLoadMorePokemons extends HomeEvent {
  const HomeLoadMorePokemons();

  @override
  List<Object> get props => [];
}

class SearchPokemons extends HomeEvent {
  final String query;

  const SearchPokemons(this.query);

  @override
  List<Object> get props => [query];
}
