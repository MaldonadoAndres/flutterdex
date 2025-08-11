import 'package:pokedex/core/network/poke_api.dart';
import 'package:pokedex/features/home/data/datasources/remote/remote_data_source.dart';

class PokeRemoteDataSource implements RemoteDataSource {
  final PokeApi _pokeApi;

  PokeRemoteDataSource(this._pokeApi);

  @override
  Future<void> getPokemons({int offset = 0}) async {
    try {
      await _pokeApi.getPokemons(offset: offset);
    } catch (e) {
      throw Exception('Failed to fetch pokemons: $e');
    }
  }
}
