abstract interface class RemoteDataSource {
  Future<void> getPokemons({int offset = 0});
}
