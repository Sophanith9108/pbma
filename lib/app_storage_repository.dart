abstract class AppStorageRepository<O> {
  Future<void> save(O value);
  Future<O?> get(String key);
  Future<List<O>?> gets();
  Future<void> update(O value);
  Future<void> delete(String key);
}
