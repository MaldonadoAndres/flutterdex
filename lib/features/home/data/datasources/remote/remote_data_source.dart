import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';

abstract interface class RemoteDataSource {
  Future<List<PokemonInfoModel>> getPokemons({int offset = 0});
}
