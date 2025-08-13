import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:pokedex/features/home/presentation/list/widgets/home_app_bar.dart';
import 'package:pokedex/features/home/presentation/list/widgets/pokemon_grid.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesBloc _favoritesBloc;

  @override
  void initState() {
    super.initState();
    _favoritesBloc = getIt<FavoritesBloc>()..add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>.value(
      value: _favoritesBloc,
      child: Scaffold(
        appBar: HomeAppBar(onSearch: (_) {}, onCancelSearch: () {}),
        body: SafeArea(
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              return switch (state) {
                FavoritesLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                FavoritesLoaded(:final favorites) => PokemonGrid(
                  pokemon: favorites,
                  enableHero: false,
                ),
                FavoritesError(message: final message) => Center(
                  child: Text(message),
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}
