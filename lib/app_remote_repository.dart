abstract class AppRemoteRepository<I> {
  Future<void> add(I value);
  Future<I> get(String key);
  Future<List<I>?> gets();
  Future<void> update(I value);
  Future<void> delete(String key);
}
