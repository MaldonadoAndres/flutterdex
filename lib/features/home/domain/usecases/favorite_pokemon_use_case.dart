import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/repositories/i_pokemon_repository.dart';

@lazySingleton
class FavoritePokemonUseCase {
  final IPokemonRepository pokemonRepository;

  FavoritePokemonUseCase(this.pokemonRepository);

  Future<Either<Failure, void>> call(PokemonInfoEntity pokemon) async {
    return await pokemonRepository.updatePokemon(pokemon);
  }
}
