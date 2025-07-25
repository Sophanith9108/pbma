abstract class AppFileUploadService {
  Future<String> create(String base64Data, {String? fileName});
  Future<String?> read(String fileId);
  Future<String> update(
    String fileId,
    String newBase64Data, {
    String? fileName,
  });
  Future<List<String>> uploads(
    List<String> base64DataList, {
    List<String>? fileNames,
  });
  Future<bool> delete(String fileId);
}
