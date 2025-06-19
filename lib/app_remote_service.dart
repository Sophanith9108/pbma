abstract class AppRemoteService<I> {
  Future<void> add(I value);
  Future<I?> read(String key);
  Future<List<I>?> reads();
  Future<void> update(I value);
  Future<void> delete(String key);
}
