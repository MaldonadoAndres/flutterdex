import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/list/bloc/home_bloc.dart';
import 'package:pokedex/features/home/presentation/list/widgets/pokemon_grid.dart';
import 'package:pokedex/features/home/presentation/list/widgets/pokemon_load_errror.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    bloc = getIt<HomeBloc>()..add(HomeLoadPokemons());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: !isSearching
                  ? const Text(
                      'FlutterDex',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : TextField(
                      onChanged: (value) {
                        context.read<HomeBloc>().add(SearchPokemons(value));
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Pokémon',
                        hintStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<HomeBloc>().add(
                                  const SearchPokemons(''),
                                );
                                setState(() {
                                  isSearching = false;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white70,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      textAlignVertical:
                          TextAlignVertical.center, // Center hint vertically
                    ),
              centerTitle: true,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              actions: !isSearching
                  ? [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => setState(() {
                          isSearching = true;
                        }),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_outline),
                        onPressed: () => {},
                      ),
                    ]
                  : null,
            ),
            body: SafeArea(
              minimum: const EdgeInsets.all(8.0),
              child: switch (state) {
                HomeLoading() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                HomeLoaded(:final pokemons) => PokemonGrid(pokemon: pokemons),
                HomeError(message: final message) => PokemonLoadError(
                  message: message,
                  onRetry: () =>
                      context.read<HomeBloc>().add(HomeLoadPokemons()),
                ),
                HomeSearchError(message: final message) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 48),
                      Text(
                        message,
                        style: const TextStyle(color: Colors.red, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                _ => const SizedBox.shrink(),
              },
            ),
          );
        },
      ),
    );
  }
}
