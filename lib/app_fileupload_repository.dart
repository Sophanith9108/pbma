abstract class AppFileUploadRepository {
  Future<String> uploadFile(String base64Data, {String? fileName});
  Future<String?> getFile(String fileId);
  Future<String> updateFile(
    String fileId,
    String newBase64Data, {
    String? fileName,
  });
  Future<List<String>> uploads(
    List<String> base64DataList, {
    List<String>? fileNames,
  });
  Future<bool> deleteFile(String fileId);
}
