import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/usecases/get_pokemon_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getPokemonUseCase) : super(HomeInitial()) {
    on<HomeLoadPokemons>(_getPokemons);
    on<HomeLoadMorePokemons>(_getMorePokemons);
    on<SearchPokemons>(_searchPokemons);
  }
  final GetPokemonUseCase _getPokemonUseCase;
  final List<PokemonInfoEntity> _pokemons = [];
  bool _isLoadingMore = false;

  Future<void> _getPokemons(
    HomeLoadPokemons event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final result = await _getPokemonUseCase();
    result.fold(
      (failure) {
        emit(HomeError(failure.message));
      },
      (pokemons) {
        _pokemons.addAll(pokemons);
        emit(HomeLoaded(pokemons));
      },
    );
  }

  Future<void> _getMorePokemons(
    HomeLoadMorePokemons event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    final result = await _getPokemonUseCase(offset: event.offset);
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (pokemons) => emit(HomeLoaded([..._pokemons, ...pokemons])),
    );
    _isLoadingMore = false;
  }

  Future<void> _searchPokemons(
    SearchPokemons event,
    Emitter<HomeState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(HomeLoaded(_pokemons));
      return;
    }

    final filteredPokemons = _pokemons
        .where(
          (pokemon) =>
              pokemon.name.toLowerCase().contains(event.query.toLowerCase()),
        )
        .toList();

    if (filteredPokemons.isEmpty) {
      emit(HomeSearchError('No Pokémon found for "${event.query}"'));
    } else {
      emit(HomeLoaded(filteredPokemons));
    }
  }
}
