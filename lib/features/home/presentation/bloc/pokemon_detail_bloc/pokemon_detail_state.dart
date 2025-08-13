part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailState extends Equatable {
  const PokemonDetailState(this.pokemonInfoEntity);
  final PokemonInfoEntity pokemonInfoEntity;

  @override
  List<Object> get props => [pokemonInfoEntity];
}

final class PokemonDetailInitial extends PokemonDetailState {
  const PokemonDetailInitial({required this.pokemon}) : super(pokemon);
  final PokemonInfoEntity pokemon;
  @override
  List<Object> get props => [pokemon];
}

final class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading({required PokemonInfoEntity pokemon})
    : super(pokemon);
}

final class PokemonUpdated extends PokemonDetailState {
  const PokemonUpdated({required this.pokemon}) : super(pokemon);

  final PokemonInfoEntity pokemon;

  @override
  List<Object> get props => [pokemon];
}

final class PokemonDetailError extends PokemonDetailState {
  const PokemonDetailError(this.message, {required PokemonInfoEntity pokemon})
    : super(pokemon);

  final String message;

  @override
  List<Object> get props => [message];
}
