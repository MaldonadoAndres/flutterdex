import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

abstract interface class IPokemonRepository {
  Future<List<PokemonInfoEntity>> getPokemons({int offset = 0});
}
