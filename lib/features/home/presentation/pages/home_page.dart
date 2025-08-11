import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app/di/injection.dart';
import 'package:pokedex/features/home/presentation/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeBloc>()..add(HomeLoadPokemons()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pokedex Home')),
        body: const Center(
          child: Text('Welcome to Pokedex!', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
