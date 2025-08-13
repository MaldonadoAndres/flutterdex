import 'package:flutter/material.dart';
import 'package:pokedex/core/widgets/bordered_text.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

class PokemonStats extends StatelessWidget {
  const PokemonStats({super.key, required this.pokemon});

  final PokemonInfoEntity pokemon;

  @override
  Widget build(BuildContext context) {
    final statColor = pokemon.types.first.typeColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BorderedText(text: 'Base Stats', fontSize: 18),
          const SizedBox(height: 8),
          _StatsRow(
            baseStat: pokemon.baseStats.hp,
            statName: 'HP',
            statColor: statColor,
          ),
          _StatsRow(
            baseStat: pokemon.baseStats.attack,
            statName: 'Attack',
            statColor: statColor,
          ),
          _StatsRow(
            baseStat: pokemon.baseStats.defense,
            statName: 'Defense',
            statColor: statColor,
          ),
          _StatsRow(
            baseStat: pokemon.baseStats.specialAttack,
            statName: 'Sp. Atk',
            statColor: statColor,
          ),
          _StatsRow(
            baseStat: pokemon.baseStats.specialDefense,
            statName: 'Sp. Def',
            statColor: statColor,
          ),
          _StatsRow(
            baseStat: pokemon.baseStats.speed,
            statName: 'Speed',
            statColor: statColor,
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.baseStat,
    required this.statName,
    required this.statColor,
  });

  final int baseStat;
  final String statName;
  final Color statColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BorderedText(text: '$statName:', fontSize: 16),
              BorderedText(text: '$baseStat', fontSize: 16),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: baseStat / 255),
            duration: Durations.long1,
            builder: (context, value, child) {
              return LinearProgressIndicator(
                minHeight: 12.0,
                value: value,
                color: statColor,
              );
            },
          ),
        ),
      ],
    );
  }
}
