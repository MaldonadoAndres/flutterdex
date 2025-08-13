import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/list/bloc/home_bloc.dart';
import 'package:pokedex/features/home/presentation/list/widgets/home_app_bar.dart';
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
            appBar: HomeAppBar(
              onSearch: (query) {
                context.read<HomeBloc>().add(SearchPokemons(query));
              },
              onCancelSearch: () {
                context.read<HomeBloc>().add(const SearchPokemons(''));
              },
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
