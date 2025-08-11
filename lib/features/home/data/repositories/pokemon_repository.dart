import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/core/error/exceptions.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/home/data/datasources/remote/remote_data_source.dart';
import 'package:pokedex/features/home/data/mappers/pokemon_model_to_entity.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/repositories/i_pokemon_repository.dart';

@LazySingleton(as: IPokemonRepository)
class PokemonRepository implements IPokemonRepository {
  final RemoteDataSource _remoteDataSource;

  PokemonRepository({required RemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<PokemonInfoEntity>>> getPokemons({
    int offset = 0,
  }) async {
    try {
      final pokemons = await _remoteDataSource.getPokemons(offset: offset);
      return Right(pokemons.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
