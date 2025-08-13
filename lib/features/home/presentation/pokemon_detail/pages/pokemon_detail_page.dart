import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/core/utils/string_extensions.dart';
import 'package:pokedex/core/widgets/bordered_text.dart';
import 'package:pokedex/core/widgets/pokemon_typing.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/presentation/pokemon_detail/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/features/home/presentation/pokemon_detail/widgets/pokemon_stats.dart';

@RoutePage()
class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.pokemon});
  final PokemonInfoEntity pokemon;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late final PokemonDetailBloc _pokemonDetailBloc;

  @override
  void initState() {
    super.initState();
    _pokemonDetailBloc = getIt<PokemonDetailBloc>(param1: widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailBloc>.value(
      value: _pokemonDetailBloc,
      child: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
        builder: (context, state) {
          final pokemon = context.select(
            (PokemonDetailBloc bloc) => bloc.state.pokemonInfoEntity,
          );
          return Scaffold(
            appBar: AppBar(
              title: BorderedText(
                text: '#${pokemon.id.toString().padLeft(3, '0')}',
                fontSize: 24,
              ),
              backgroundColor: pokemon.types.first.typeColor.withAlpha(100),
              actions: [
                IconButton(
                  icon: Icon(
                    pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    context.read<PokemonDetailBloc>().add(
                      ToggleFavorite(pokemon),
                    );
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: pokemon.types.first.typeColor.withAlpha(100),
                      borderRadius: const BorderRadius.only(
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
                            imageUrl: widget.pokemon.officialArtwork,
                            height: 200,
                            width: 200,
                          ),
                        ),
                        BorderedText(
                          text: pokemon.name.capitalize,
                          fontSize: 18,
                        ),
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
                            const BorderedText(text: 'Height'),
                            BorderedText(text: '${pokemon.height / 10} m'),
                          ],
                        ),
                        Column(
                          children: [
                            const BorderedText(text: 'Weight'),
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
        },
      ),
    );
  }
}
