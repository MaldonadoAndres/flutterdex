import 'package:pokedex/features/home/data/datasources/local/local_data_source.dart';
import 'package:pokedex/features/home/data/datasources/remote/remote_data_source.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/repositories/i_pokemon_repository.dart';

class PokemonRepository implements IPokemonRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  PokemonRepository({required RemoteDataSource remoteDataSource, required LocalDataSource localDataSource})
    : _remoteDataSource = remoteDataSource,
      _localDataSource = localDataSource;

  @override
  Future<List<PokemonInfoEntity>> getPokemons({int offset = 0}) async {
    await _remoteDataSource.getPokemons(offset: offset);
    return <PokemonInfoEntity>[];
  }
}
