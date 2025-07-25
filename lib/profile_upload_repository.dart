import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileUploadRepository extends AppFileUploadRepository {
  final ProfileUploadService _service = Get.put(ProfileUploadService());

  @override
  Future<bool> deleteFile(String fileId) async {
    try {
      return await _service.delete(fileId);
    } catch (e) {
      AppUtils.logging("$e");
      return false;
    }
  }

  @override
  Future<String?> getFile(String fileId) async {
    try {
      return await _service.read(fileId);
    } catch (e) {
      AppUtils.logging("$e");
      return "$e";
    }
  }

  @override
  Future<String> updateFile(
    String fileId,
    String newBase64Data, {
    String? fileName,
  }) async {
    try {
      return await _service.update(fileId, newBase64Data, fileName: fileName);
    } catch (e) {
      AppUtils.logging("$e");
      return '$e';
    }
  }

  @override
  Future<String> uploadFile(String base64Data, {String? fileName}) async {
    try {
      return await _service.create(base64Data, fileName: fileName);
    } catch (e) {
      AppUtils.logging("$e");
      return '$e';
    }
  }

  @override
  Future<List<String>> uploads(
    List<String> base64DataList, {
    List<String>? fileNames,
  }) async {
    try {
      return await _service.uploads(base64DataList, fileNames: fileNames);
    } catch (e) {
      AppUtils.logging("$e");
      return [];
    }
  }
}
