import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/usecases/get_favorites_pokemon_use_case.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

@Injectable()
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<PokemonInfoEntity> _favorites = [];
  final GetFavoritesPokemonUseCase _getFavoritesPokemonUseCase;

  FavoritesBloc(this._getFavoritesPokemonUseCase) : super(FavoritesLoading()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<FilteredFavorites>(_onFilteredFavorites);
  }
  void _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await _getFavoritesPokemonUseCase();
    result.fold((failure) => emit(FavoritesError(failure.message)), (
      favorites,
    ) {
      _favorites.addAll(favorites);
      emit(FavoritesLoaded(favorites: _favorites));
    });
  }

  void _onFilteredFavorites(
    FilteredFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    if (event.query.trim().isEmpty) {
      emit(FavoritesLoaded(favorites: _favorites));
      return;
    }
    final filteredPokemons = _favorites
        .where(
          (pokemon) =>
              pokemon.name.toLowerCase().contains(event.query.toLowerCase()),
        )
        .toList();

    if (filteredPokemons.isEmpty) {
      emit(FavoritesError('No Pokémon found for "${event.query}"'));
    } else {
      emit(FavoritesLoaded(favorites: filteredPokemons));
    }
  }
}
