import 'package:injectable/injectable.dart';
import 'package:pokedex/features/home/data/datasources/local/local_data_source.dart';

@LazySingleton(as: LocalDataSource)
class HiveLocalDataSource implements LocalDataSource {}
