class PokemonInfoEntity {
  final int id;
  final int height;
  final int weight;
  final String name;
  final String shortDescription;
  final String backSprite;
  final String frontSprite;
  final PokemonStatsEntity baseStats;
  final List<PokemonType> types;

  PokemonInfoEntity({
    required this.id,
    required this.height,
    required this.weight,
    required this.name,
    required this.shortDescription,
    required this.backSprite,
    required this.frontSprite,
    required this.baseStats,
    required this.types,
  });
}

class PokemonStatsEntity {
  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final int specialAttack;
  final int specialDefense;

  PokemonStatsEntity({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.specialAttack,
    required this.specialDefense,
  });
}

enum PokemonType {
  normal,
  fire,
  water,
  electric,
  grass,
  ice,
  fighting,
  poison,
  ground,
  flying,
  psychic,
  bug,
  rock,
  ghost,
  dragon,
  dark,
  steel,
  fairy,
}
