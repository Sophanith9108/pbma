abstract class AppStorageService<O> {
  Future<void> create(O value);
  Future<O?> read(String key);
  Future<List<O>?> reads();
  Future<void> update(O value);
  Future<void> delete(String key);
}
