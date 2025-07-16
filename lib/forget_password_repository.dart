import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ForgetPasswordRepository extends AppFirebaseStorageRepository<UserModel> {
  final ForgetPasswordService _service = Get.put(ForgetPasswordService());

  @override
  Future<UserModel> create(UserModel data) async {
    return await _service.create(data);
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id);
  }

  @override
  Future<UserModel> read(String id) async {
    return await _service.read(id);
  }

  @override
  Future<List<UserModel>> reads() async {
    return await _service.reads();
  }

  @override
  Future<UserModel> update(UserModel data) async {
    return await _service.update(data);
  }
}
