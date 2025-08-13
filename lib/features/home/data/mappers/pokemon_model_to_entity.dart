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
      isFavorite: isFavorite,
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

extension PokemonInfoEntityExtention on PokemonInfoEntity {
  PokemonInfoModel toModel() {
    return PokemonInfoModel(
      id: id,
      height: height,
      weight: weight,
      name: name,
      isFavorite: isFavorite,
      sprites: PokemonSpritesModel(
        backDefault: backSprite,
        frontDefault: frontSprite,
        officialArtwork: officialArtwork,
      ),
      stats: PokemonStatsModel(
        hp: baseStats.hp,
        attack: baseStats.attack,
        defense: baseStats.defense,
        speed: baseStats.speed,
        specialAttack: baseStats.specialAttack,
        specialDefense: baseStats.specialDefense,
      ),
      types: types,
    );
  }
}
