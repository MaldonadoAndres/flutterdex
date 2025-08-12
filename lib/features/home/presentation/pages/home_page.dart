import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/bloc/home_bloc.dart';
import 'package:pokedex/features/home/presentation/widgets/pokemon_grid.dart';
import 'package:pokedex/features/home/presentation/widgets/pokemon_load_errror.dart';

@RoutePage()
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
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'FlutterDex',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_outline),
                  onPressed: () => {},
                ),
              ],
            ),
            body: SafeArea(
              minimum: const EdgeInsets.all(8.0),
              child: switch (state) {
                HomeLoading() => Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                HomeLoaded(:final pokemons) => PokemonGrid(pokemon: pokemons),
                HomeError(message: final message) => PokemonLoadError(
                  message: message,
                  onRetry: () => bloc.add(HomeLoadPokemons()),
                ),
                _ => SizedBox.shrink(),
              },
            ),
          );
        },
      ),
    );
  }
}
