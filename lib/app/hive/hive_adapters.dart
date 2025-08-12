import 'package:hive_ce/hive.dart';
import 'package:pokedex/features/home/data/models/pokemon_info_model.dart';
import 'package:pokedex/features/home/domain/entities/pokemon_info_entity.dart';

@GenerateAdapters([
  AdapterSpec<PokemonInfoModel>(),
  AdapterSpec<PokemonSpritesModel>(),
  AdapterSpec<PokemonStatsModel>(),
  AdapterSpec<PokemonType>(),
])
part 'hive_adapters.g.dart';
