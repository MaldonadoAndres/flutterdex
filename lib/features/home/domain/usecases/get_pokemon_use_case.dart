import 'package:injectable/injectable.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';
import 'package:pokedex/features/home/domain/repositories/i_pokemon_repository.dart';

@lazySingleton
class GetPokemonUseCase {
  final IPokemonRepository _repository;

  GetPokemonUseCase({required IPokemonRepository repository}) : _repository = repository;

  Future<List<PokemonInfoEntity>> call({int offset = 0}) {
    return _repository.getPokemons(offset: offset);
  }
}
