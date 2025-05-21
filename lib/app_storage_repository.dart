abstract class AppStorageRepository<O> {
  Future<void> save(String key, O value);
  Future<O?> get(String key);
  Future<List<O>?> gets(String key);
  Future<void> update(String key, O value);
  Future<void> delete(String key);
}
