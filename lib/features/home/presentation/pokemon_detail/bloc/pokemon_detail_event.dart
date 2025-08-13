part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object> get props => [];
}

class ToggleFavorite extends PokemonDetailEvent {
  const ToggleFavorite(this.pokemon);

  final PokemonInfoEntity pokemon;

  @override
  List<Object> get props => [pokemon];
}
