import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'package:pokedex/core/network/poke_api.dart';
import 'package:pokedex/features/home/data/datasources/remote/remote_data_source.dart';
import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';

@LazySingleton(as: RemoteDataSource)
class PokeRemoteDataSource implements RemoteDataSource {
  final PokeApi _pokeApi;

  PokeRemoteDataSource(this._pokeApi);

  @override
  Future<List<PokemonInfoModel>> getPokemons({int offset = 0}) async {
    try {
      final response = await _pokeApi.getPokemons(offset: offset);
      final pokemonList = response.results;
      final result = await Future.wait([
        for (final pokemon in pokemonList)
          _pokeApi.getPokemonsByName(name: pokemon.name),
      ]);
      return result;
    } catch (e) {
      Logger().e(
        'Error fetching pokemons: $e',
        error: e,
        stackTrace: StackTrace.current,
      );
      throw Exception('Failed to fetch pokemons: $e');
    }
  }
}
