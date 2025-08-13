// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/network/poke_api.dart' as _i188;
import '../../features/home/data/datasources/local/hive_local_data_source.dart'
    as _i49;
import '../../features/home/data/datasources/local/local_data_source.dart'
    as _i519;
import '../../features/home/data/datasources/remote/poke_remote_data_source.dart'
    as _i1021;
import '../../features/home/data/datasources/remote/remote_data_source.dart'
    as _i623;
import '../../features/home/data/models/pokemon_info_model.dart' as _i976;
import '../../features/home/data/repositories/pokemon_repository.dart' as _i749;
import '../../features/home/domain/entities/pokemon_info_entity.dart' as _i506;
import '../../features/home/domain/repositories/i_pokemon_repository.dart'
    as _i236;
import '../../features/home/domain/usecases/favorite_pokemon_use_case.dart'
    as _i3;
import '../../features/home/domain/usecases/get_pokemon_use_case.dart' as _i683;
import '../../features/home/presentation/bloc/home_bloc/home_bloc.dart'
    as _i771;
import '../../features/home/presentation/bloc/pokemon_detail_bloc/pokemon_detail_bloc.dart'
    as _i972;
import 'hive_module.dart' as _i576;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    final registerModule = _$RegisterModule();
    await gh.lazySingletonAsync<_i919.Box<_i976.PokemonInfoModel>>(
      () => hiveModule.pokemonBox(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i188.PokeApi>(
      () => registerModule.pokeApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i623.RemoteDataSource>(
      () => _i1021.PokeRemoteDataSource(gh<_i188.PokeApi>()),
    );
    gh.lazySingleton<_i519.LocalDataSource>(
      () => _i49.HiveLocalDataSource(gh<_i919.Box<_i976.PokemonInfoModel>>()),
    );
    gh.lazySingleton<_i236.IPokemonRepository>(
      () => _i749.PokemonRepository(
        remoteDataSource: gh<_i623.RemoteDataSource>(),
        localDataSource: gh<_i519.LocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i3.FavoritePokemonUseCase>(
      () => _i3.FavoritePokemonUseCase(gh<_i236.IPokemonRepository>()),
    );
    gh.lazySingleton<_i683.GetPokemonUseCase>(
      () => _i683.GetPokemonUseCase(repository: gh<_i236.IPokemonRepository>()),
    );
    gh.factoryParam<_i972.PokemonDetailBloc, _i506.PokemonInfoEntity, dynamic>(
      (pokemon, _) =>
          _i972.PokemonDetailBloc(gh<_i3.FavoritePokemonUseCase>(), pokemon),
    );
    gh.factory<_i771.HomeBloc>(
      () => _i771.HomeBloc(gh<_i683.GetPokemonUseCase>()),
    );
    return this;
  }
}

class _$HiveModule extends _i576.HiveModule {}

class _$RegisterModule extends _i291.RegisterModule {}
