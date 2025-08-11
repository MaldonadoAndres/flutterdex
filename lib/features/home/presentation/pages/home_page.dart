import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/core/utils/string_extensions.dart';
import 'package:pokedex/features/home/presentation/bloc/home_bloc.dart';

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
        appBar: AppBar(title: const Text('Pokedex')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            Logger().d('Current state: ${state.runtimeType}');
            return switch (state) {
              HomeLoading() => const Center(child: CircularProgressIndicator()),
              HomeLoaded(:final pokemons) => ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemons[index];
                  return ListTile(
                    title: Text(pokemon.name.capitalize),
                    subtitle: Text(
                      'Pokedex Entry: ${pokemon.id} Types: ${pokemon.types.map((e) => e.name.capitalize).join(', ')}',
                    ),
                  );
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
    );
  }
}
