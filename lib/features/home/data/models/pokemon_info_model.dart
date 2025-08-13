import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

part 'pokemon_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonInfoModel with HiveObjectMixin {
  final int? id;
  final int? height;
  final int? weight;
  final String? name;
  final PokemonSpritesModel? sprites;
  @JsonKey(fromJson: PokemonStatsModel.fromJson)
  final PokemonStatsModel? stats;
  @JsonKey(fromJson: PokemonType.fromJsonList)
  final List<PokemonType>? types;
  @JsonKey(includeFromJson: false)
  final bool isFavorite;

  PokemonInfoModel({
    required this.id,
    required this.height,
    required this.weight,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.types,
    this.isFavorite = false,
  });
  factory PokemonInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonInfoModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  BoxBase? get box => super.box;
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PokemonSpritesModel with HiveObjectMixin {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
  @JsonKey(fromJson: _officialArtworkFromJson, name: 'other')
  final String? officialArtwork;

  PokemonSpritesModel({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.officialArtwork,
  });

  factory PokemonSpritesModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesModelFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonSpritesModelToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  BoxBase? get box => super.box;

  static String? _officialArtworkFromJson(Map<String, dynamic> json) {
    return json['official-artwork']['front_default'] as String?;
  }
}

@JsonSerializable(createFactory: false)
class PokemonStatsModel with HiveObjectMixin {
  final int? hp;
  final int? attack;
  final int? defense;
  final int? speed;
  final int? specialAttack;
  final int? specialDefense;

  PokemonStatsModel({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.specialAttack,
    required this.specialDefense,
  });
  Map<String, dynamic> toJson() => _$PokemonStatsModelToJson(this);
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  BoxBase? get box => super.box;

  factory PokemonStatsModel.fromJson(List<dynamic> json) {
    final statMap = <String, int?>{};
    for (final stat in json) {
      final statName = stat['stat']['name'] as String?;
      final baseStat = stat['base_stat'] as int?;
      if (statName != null) {
        statMap[statName] = baseStat;
      }
    }

    return PokemonStatsModel(
      hp: statMap['hp'] ?? -1,
      attack: statMap['attack'] ?? -1,
      defense: statMap['defense'] ?? -1,
      speed: statMap['speed'] ?? -1,
      specialAttack: statMap['special-attack'] ?? -1,
      specialDefense: statMap['special-defense'] ?? -1,
    );
  }
}
