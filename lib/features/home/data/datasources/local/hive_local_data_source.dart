import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pokedex/core/error/exceptions.dart';
import 'package:pokedex/features/home/data/datasources/local/local_data_source.dart';
import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';

@LazySingleton(as: LocalDataSource)
class HiveLocalDataSource implements LocalDataSource {
  final Box<PokemonInfoModel> _pokemonBox;

  HiveLocalDataSource(this._pokemonBox);

  @override
  Future<void> savePokemon(List<PokemonInfoModel> pokemon) async {
    try {
      await _pokemonBox.addAll(pokemon);
    } on HiveError catch (e) {
      Logger().e('Failed to save Pokemon: ${e.message}');
      throw CacheException();
    }
  }

  @override
  Future<List<PokemonInfoModel>> getPokemon() async {
    try {
      return _pokemonBox.values.toList();
    } on HiveError catch (e) {
      Logger().e('Failed to get Pokemon: ${e.message}');
      throw CacheException();
    }
  }

  @override
  Future<void> updatePokemon(PokemonInfoModel pokemon) async {
    try {
      final index = _pokemonBox.values.toList().indexWhere(
        (p) => p.id == pokemon.id,
      );
      if (index == -1) {
        throw CacheException('Pokemon not found');
      }
      await _pokemonBox.putAt(index, pokemon);
    } on HiveError catch (e) {
      Logger().e('Failed to update Pokemon: ${e.message}');
      throw CacheException();
    }
  }

  @override
  Future<List<PokemonInfoModel>> getFavoritesPokemon() async {
    try {
      return _pokemonBox.values.where((pokemon) => pokemon.isFavorite).toList();
    } on HiveError catch (e) {
      Logger().e('Failed to get favorite Pokemon: ${e.message}');
      throw CacheException();
    }
  }
}
