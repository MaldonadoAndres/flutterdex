import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/bloc/home_bloc.dart';
import 'package:pokedex/features/home/presentation/widgets/pokemon_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = getIt<HomeBloc>()..add(HomeLoadPokemons());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex'),
          centerTitle: true,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return switch (state) {
                HomeLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                HomeLoaded(:final pokemons) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];
                    return PokemonCard(pokemon: pokemon);
                  },
                ),
                HomeError(message: final message) => Center(
                  child: Text('Error: $message'),
                ),
                _ => const Center(child: Text('Welcome to the Pokedex!!')),
              };
            },
          ),
        ),
      ),
    );
  }
}
