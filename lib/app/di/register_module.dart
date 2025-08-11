// register_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/core/network/dio_client.dart';
import 'package:pokedex/core/network/poke_api.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => createDio();

  @lazySingleton
  PokeApi pokeApi(Dio dio) => PokeApi(dio);
}
