part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadPokemons extends HomeEvent {}

class HomeLoadMorePokemons extends HomeEvent {
  final int offset;

  const HomeLoadMorePokemons(this.offset);

  @override
  List<Object> get props => [offset];
}
