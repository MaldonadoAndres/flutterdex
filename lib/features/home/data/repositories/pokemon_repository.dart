import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/core/error/exceptions.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/home/data/datasources/local/local_data_source.dart';
import 'package:pokedex/features/home/data/datasources/remote/remote_data_source.dart';
import 'package:pokedex/features/home/data/mappers/pokemon_model_to_entity.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/repositories/i_pokemon_repository.dart';

@LazySingleton(as: IPokemonRepository)
class PokemonRepository implements IPokemonRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  PokemonRepository({
    required RemoteDataSource remoteDataSource,
    required LocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<PokemonInfoEntity>>> getPokemons({
    int offset = 0,
  }) async {
    try {
      final localPokemon = await _getLocalPokemon();

      /// If localPokemon is not empty and offset is less than localPokemon length, return localPokemon
      ///  If offset is greater than or equal to localPokemon length, fetch from remote
      if (localPokemon.isNotEmpty && offset < localPokemon.length) {
        return Right(localPokemon);
      }
      final pokemons = await _remoteDataSource.getPokemons(offset: offset);
      await _localDataSource.savePokemon(pokemons);
      return Right(pokemons.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure());
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }

  Future<List<PokemonInfoEntity>> _getLocalPokemon() async {
    try {
      final localPokemon = await _localDataSource.getPokemon();
      return localPokemon.map((e) => e.toEntity()).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Either<Failure, void>> updatePokemon(PokemonInfoEntity pokemon) async {
    try {
      await _localDataSource.updatePokemon(pokemon.toModel());
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message ?? 'Failed to update Pokemon'));
    }
  }

  @override
  Future<Either<Failure, List<PokemonInfoEntity>>> getFavoritePokemons() async {
    try {
      final favorites = await _localDataSource.getFavoritesPokemon();
      return Right(favorites.map((e) => e.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message ?? 'Failed to get favorite Pokemon'));
    }
  }
}
