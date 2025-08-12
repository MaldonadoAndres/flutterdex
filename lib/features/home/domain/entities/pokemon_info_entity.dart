import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokemonInfoEntity extends Equatable {
  final int id;
  final int height;
  final int weight;
  final String name;
  final String shortDescription;
  final String backSprite;
  final String frontSprite;
  final String officialArtwork;
  final PokemonStatsEntity baseStats;
  final List<PokemonType> types;

  const PokemonInfoEntity({
    required this.id,
    required this.height,
    required this.weight,
    required this.name,
    required this.shortDescription,
    required this.backSprite,
    required this.frontSprite,
    required this.officialArtwork,
    required this.baseStats,
    required this.types,
  });

  @override
  List<Object?> get props => [id];
}

class PokemonStatsEntity extends Equatable {
  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final int specialAttack;
  final int specialDefense;

  const PokemonStatsEntity({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.specialAttack,
    required this.specialDefense,
  });

  factory PokemonStatsEntity.empty() {
    return const PokemonStatsEntity(
      hp: 0,
      attack: 0,
      defense: 0,
      speed: 0,
      specialAttack: 0,
      specialDefense: 0,
    );
  }

  @override
  List<Object?> get props => [
    hp,
    attack,
    defense,
    speed,
    specialAttack,
    specialDefense,
  ];
}

enum PokemonType {
  normal(typeColor: Color(0xFF9FA19F)),
  fire(typeColor: Color(0xFFE62829)),
  water(typeColor: Color(0xFF2980EF)),
  electric(typeColor: Color(0xFFFABF00)),
  grass(typeColor: Color(0xFF3FA129)),
  ice(typeColor: Color(0xFF3CCEF3)),
  fighting(typeColor: Color(0xFFFF8001)),
  poison(typeColor: Color(0xFF9141CB)),
  ground(typeColor: Color(0xFF905120)),
  flying(typeColor: Color(0xFF81B8EF)),
  psychic(typeColor: Color(0xFFEE4178)),
  bug(typeColor: Color(0xFF91A119)),
  rock(typeColor: Color(0xFFAFA980)),
  ghost(typeColor: Color(0xFF6F416F)),
  dragon(typeColor: Color(0xFF4F60E1)),
  dark(typeColor: Color(0xFF624D4D)),
  steel(typeColor: Color(0xFF60A0B7)),
  fairy(typeColor: Color(0xFFEF70EF)),
  unknown(typeColor: Colors.white);

  final Color typeColor;

  static List<PokemonType> fromJsonList(List<dynamic> json) {
    return json.map((e) => PokemonType.fromJson(e)).toList();
  }

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType.values.firstWhere(
      (e) => e.name == json['type']['name'],
      orElse: () => PokemonType.unknown,
    );
  }

  const PokemonType({required this.typeColor});
}
