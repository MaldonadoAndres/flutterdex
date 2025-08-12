import 'package:flutter/material.dart';
import 'package:pokedex/core/utils/string_extensions.dart';
import 'package:pokedex/core/widgets/bordered_text.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

class PokemonTyping extends StatelessWidget {
  const PokemonTyping({super.key, required this.pokemon, this.fontSize = 14.0});

  final PokemonInfoEntity pokemon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.start,
      children: [
        ...pokemon.types.map((type) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: type.typeColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: BorderedText(text: type.name.capitalize, fontSize: fontSize),
          );
        }),
      ],
    );
  }
}
