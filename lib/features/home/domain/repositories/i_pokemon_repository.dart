import 'package:dartz/dartz.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

abstract interface class IPokemonRepository {
  Future<Either<Failure, List<PokemonInfoEntity>>> getPokemons({
    int offset = 0,
  });
  Future<Either<Failure, void>> updatePokemon(PokemonInfoEntity pokemon);
}
