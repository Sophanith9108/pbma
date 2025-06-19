abstract class AppFirebaseStorageRepository<T> {
  Future<T> create(T data);
  Future<T> read(String id);
  Future<List<T>> reads();
  Future<T> update(T data);
  Future<void> delete(String id);
}
