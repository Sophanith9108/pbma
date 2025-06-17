import 'package:get/get.dart';
import 'package:pbma/core.dart';

class UserFirebaseRepository extends AppRemoteRepository<UserModel> {
  final UserFirebaseService _service = Get.put(UserFirebaseService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<UserModel> get(String key) async {
    return _service.read(key);
  }

  @override
  Future<List<UserModel>?> gets() async {
    return _service.reads();
  }

  @override
  Future<void> save(UserModel value) async {
    return _service.add(value);
  }

  @override
  Future<void> update(UserModel value) async {
    return _service.update(value);
  }
}
