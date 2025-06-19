import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ImageUploadRepository extends AppFirebaseStorageRepository<String> {
  final ImageUploadService _service = Get.put(ImageUploadService());

  @override
  Future<String> create(String data) async {
    return await _service.create(data);
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id);
  }

  @override
  Future<String> read(String id) async {
    return await _service.read(id);
  }

  @override
  Future<List<String>> reads() async {
    return await _service.reads();
  }

  @override
  Future<String> update(String data) async {
    return await _service.update(data);
  }
}
