// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart'
    as _i5;
import 'package:pokedex/features/home/presentation/pages/home_page.dart' as _i1;
import 'package:pokedex/features/home/presentation/pages/pokemon_detail_page.dart'
    as _i2;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.PokemonDetailPage]
class PokemonDetailRoute extends _i3.PageRouteInfo<PokemonDetailRouteArgs> {
  PokemonDetailRoute({
    _i4.Key? key,
    required _i5.PokemonInfoEntity pokemon,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         PokemonDetailRoute.name,
         args: PokemonDetailRouteArgs(key: key, pokemon: pokemon),
         initialChildren: children,
       );

  static const String name = 'PokemonDetailRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PokemonDetailRouteArgs>();
      return _i2.PokemonDetailPage(key: args.key, pokemon: args.pokemon);
    },
  );
}

class PokemonDetailRouteArgs {
  const PokemonDetailRouteArgs({this.key, required this.pokemon});

  final _i4.Key? key;

  final _i5.PokemonInfoEntity pokemon;

  @override
  String toString() {
    return 'PokemonDetailRouteArgs{key: $key, pokemon: $pokemon}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PokemonDetailRouteArgs) return false;
    return key == other.key && pokemon == other.pokemon;
  }

  @override
  int get hashCode => key.hashCode ^ pokemon.hashCode;
}
