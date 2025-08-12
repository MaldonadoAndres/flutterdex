import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

extension PokemonModelToEntity on PokemonInfoModel {
  PokemonInfoEntity toEntity() {
    return PokemonInfoEntity(
      id: id ?? -1,
      height: height ?? -1,
      weight: weight ?? -1,
      name: name ?? '',
      backSprite: sprites?.backDefault ?? '',
      frontSprite: sprites?.frontDefault ?? '',
      officialArtwork: sprites?.officialArtwork ?? '',
      baseStats: stats?.toEntity() ?? PokemonStatsEntity.empty(),
      shortDescription: '',
      types: types ?? [],
    );
  }
}

extension PokemonStatsModelToEntity on PokemonStatsModel? {
  PokemonStatsEntity toEntity() {
    return PokemonStatsEntity(
      hp: this?.hp ?? -1,
      attack: this?.attack ?? -1,
      defense: this?.defense ?? -1,
      speed: this?.speed ?? -1,
      specialAttack: this?.specialAttack ?? -1,
      specialDefense: this?.specialDefense ?? -1,
    );
  }
}
