import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/app/hive/hive_adapters.dart';
import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';

@module
abstract class HiveModule {
  // Ensure Hive is ready and box is open before usage
  @preResolve
  @lazySingleton
  Future<Box<PokemonInfoModel>> pokemonBox() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PokemonInfoModelAdapter());
    Hive.registerAdapter(PokemonSpritesModelAdapter());
    Hive.registerAdapter(PokemonStatsModelAdapter());
    Hive.registerAdapter(PokemonTypeAdapter());
    return await Hive.openBox<PokemonInfoModel>('pokemon_box');
  }
}
