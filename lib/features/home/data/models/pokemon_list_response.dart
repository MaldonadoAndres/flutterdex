import 'package:json_annotation/json_annotation.dart';

part 'pokemon_list_response.g.dart';

@JsonSerializable()
class PokemonListResponse {
  final String? next;
  final String? previous;
  final List<PokemonResult> results;

  PokemonListResponse({required this.next, this.previous, required this.results});
}

@JsonSerializable()
class PokemonResult {
  final String name;
  final String url;

  PokemonResult({required this.name, required this.url});
}
