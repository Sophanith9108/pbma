import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TargetFirebaseRepository
    extends AppFirebaseStorageRepository<TargetModel> {
  final TargetFirebaseService _service = Get.put(TargetFirebaseService());

  @override
  Future<TargetModel> create(TargetModel data) async {
    return await _service.create(data);
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id);
  }

  @override
  Future<TargetModel> read(String id) async {
    return await _service.read(id);
  }

  @override
  Future<List<TargetModel>> reads() async {
    return await _service.reads();
  }

  @override
  Future<TargetModel> update(TargetModel data) async {
    return await _service.update(data);
  }
}
