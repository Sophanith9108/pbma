abstract class AppFirebaseStorageService<G> {
  Future<G> create(G data);
  Future<G> read(String id);
  Future<List<G>> reads();
  Future<G> update(G data);
  Future<void> delete(String id);
}
