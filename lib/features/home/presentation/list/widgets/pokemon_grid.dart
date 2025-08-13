import 'package:flutter/material.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/presentation/list/widgets/pokemon_card.dart';

class PokemonGrid extends StatefulWidget {
  const PokemonGrid({
    super.key,
    required this.pokemon,
    this.enableHero = true,
    this.onLoadMore,
  });
  final List<PokemonInfoEntity> pokemon;
  final bool enableHero;
  final Function()? onLoadMore;

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) widget.onLoadMore?.call();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.7);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pokemon.isEmpty) {
      return const Center(child: Text('No Pokémon found.'));
    }

    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
      ),
      itemCount: widget.pokemon.length,
      itemBuilder: (context, index) {
        final pokemon = widget.pokemon[index];
        return PokemonCard(pokemon: pokemon, enableHero: widget.enableHero);
      },
    );
  }
}
