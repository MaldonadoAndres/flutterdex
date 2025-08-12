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
  }
  final GetPokemonUseCase _getPokemonUseCase;

  Future<void> _getPokemons(
    HomeLoadPokemons event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final result = await _getPokemonUseCase();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (pokemons) => emit(HomeLoaded(pokemons)),
    );
  }

  Future<void> _getMorePokemons(
    HomeLoadMorePokemons event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoaded) return;
    final currentState = state as HomeLoaded;
    final result = await _getPokemonUseCase(offset: event.offset);
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (pokemons) => emit(HomeLoaded([...currentState.pokemons, ...pokemons])),
    );
  }
}
