import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/presentation/list/bloc/home_bloc.dart';
import 'package:pokedex/features/home/presentation/list/widgets/pokemon_card.dart';

class PokemonGrid extends StatefulWidget {
  const PokemonGrid({super.key, required this.pokemon});
  final List<PokemonInfoEntity> pokemon;

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    //TODO: Implement debouncer
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final bloc = context.read<HomeBloc>();
        if (bloc.state is! HomeLoaded) return;
        final loadedState = bloc.state as HomeLoaded;
        bloc.add(HomeLoadMorePokemons(loadedState.pokemons.length));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
      ),
      itemCount: widget.pokemon.length,
      itemBuilder: (context, index) {
        final pokemon = widget.pokemon[index];
        return PokemonCard(pokemon: pokemon);
      },
    );
  }
}
