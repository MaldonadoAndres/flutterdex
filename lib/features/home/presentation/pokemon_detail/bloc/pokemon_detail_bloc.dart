import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/usecases/favorite_pokemon_use_case.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

@Injectable()
class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  final FavoritePokemonUseCase _favoritePokemonUseCase;

  PokemonDetailBloc(
    this._favoritePokemonUseCase,
    @factoryParam PokemonInfoEntity pokemon,
  ) : super(PokemonDetailInitial(pokemon: pokemon)) {
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<PokemonDetailState> emit,
  ) async {
    emit(PokemonDetailLoading(pokemon: event.pokemon));
    final updatedPokemon = event.pokemon.copyWith(
      isFavorite: !event.pokemon.isFavorite,
    );

    final result = await _favoritePokemonUseCase(updatedPokemon);
    result.fold(
      (failure) =>
          emit(PokemonDetailError(failure.message, pokemon: event.pokemon)),
      (_) => emit(PokemonUpdated(pokemon: updatedPokemon)),
    );
  }
}
