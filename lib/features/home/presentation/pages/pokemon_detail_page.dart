import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/core/utils/string_extensions.dart';
import 'package:pokedex/core/widgets/bordered_text.dart';
import 'package:pokedex/core/widgets/pokemon_typing.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/presentation/widgets/pokemon_stats.dart';

@RoutePage()
class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key, required this.pokemon});
  final PokemonInfoEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BorderedText(
          text: '#${pokemon.id.toString().padLeft(3, '0')}',
          fontSize: 24,
        ),
        backgroundColor: pokemon.types.first.typeColor.withAlpha(100),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: pokemon.types.first.typeColor.withAlpha(100),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Hero(
                    tag: pokemon.id,
                    child: CachedNetworkImage(
                      imageUrl: pokemon.officialArtwork,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  BorderedText(text: pokemon.name.capitalize, fontSize: 18),
                  PokemonTyping(pokemon: pokemon, fontSize: 18),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Column(
                    children: [
                      BorderedText(text: 'Height'),
                      BorderedText(text: '${pokemon.height / 10} m'),
                    ],
                  ),
                  Column(
                    children: [
                      BorderedText(text: 'Weight'),
                      BorderedText(text: '${pokemon.weight / 10} kg'),
                    ],
                  ),
                ],
              ),
            ),
            PokemonStats(pokemon: pokemon),
          ],
        ),
      ),
    );
  }
}
