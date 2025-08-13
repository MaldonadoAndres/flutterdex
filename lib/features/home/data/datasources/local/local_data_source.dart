import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';

abstract interface class LocalDataSource {
  Future<void> savePokemon(List<PokemonInfoModel> pokemon);
  Future<List<PokemonInfoModel>> getPokemon();
  Future<void> updatePokemon(PokemonInfoModel pokemon);
}
