import 'package:pokedex/core/network/dio_client.dart';
import 'package:pokedex/features/home/data/models/pokemon_list_response.dart';
import 'package:retrofit/retrofit.dart';

part 'poke_api.g.dart';

@RestApi(baseUrl: 'https://pokeapi.co/api/v2/')
abstract class PokeApi {
  factory PokeApi() {
    final dio = createDio();
    return _PokeApi(dio);
  }

  @GET('pokemon')
  Future<PokemonListResponse> getPokemons({@Query('limit') int limit = 10, @Query('offset') int offset = 0});
}
