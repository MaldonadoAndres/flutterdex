import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/router/pokemon_router.gr.dart';
import 'package:pokedex/core/utils/string_extensions.dart';
import 'package:pokedex/core/widgets/bordered_text.dart';
import 'package:pokedex/core/widgets/pokemon_typing.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});
  final PokemonInfoEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PokemonDetailRoute(pokemon: pokemon).push(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: pokemon.types.first.typeColor.withAlpha(100),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BorderedText(text: pokemon.name.capitalize),
                  BorderedText(
                    text: '#${pokemon.id.toString().padLeft(3, '0')}',
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: PokemonTyping(pokemon: pokemon)),
                    Hero(
                      tag: pokemon.id,
                      child: CachedNetworkImage(
                        imageUrl: pokemon.officialArtwork,
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
