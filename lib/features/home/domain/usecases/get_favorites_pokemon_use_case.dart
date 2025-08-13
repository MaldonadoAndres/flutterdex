import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/repositories/i_pokemon_repository.dart';

@lazySingleton
class GetFavoritesPokemonUseCase {
  final IPokemonRepository repository;

  GetFavoritesPokemonUseCase(this.repository);

  Future<Either<Failure, List<PokemonInfoEntity>>> call() {
    return repository.getFavoritePokemons();
  }
}
