import 'package:dio/dio.dart';
import 'package:pokedex/features/home/data/models/pokemon_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'poke_api.g.dart';

@RestApi(baseUrl: 'https://pokeapi.co/api/v2/')
abstract class PokeApi {
  factory PokeApi(Dio dioClient) = _PokeApi;

  @GET('pokemon')
  Future<PokemonListResponse> getPokemons({@Query('limit') int limit = 10, @Query('offset') int offset = 0});
}
