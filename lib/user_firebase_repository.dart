import 'package:get/get.dart';
import 'package:pbma/core.dart';

class UserFirebaseRepository extends AppFirebaseStorageRepository<UserModel> {
  final UserFirebaseService _service = Get.put(UserFirebaseService());

  @override
  Future<UserModel> create(UserModel data) async {
    return await _service.create(data).catchError((error) {
      throw Exception("Failed to create user: $error");
    });
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id).catchError((error) {
      throw Exception("Failed to delete user: $error");
    });
  }

  @override
  Future<UserModel> read(String id) async {
    return await _service.read(id).catchError((error) {
      throw Exception("Failed to read user: $error");
    });
  }

  @override
  Future<List<UserModel>> reads() async {
    return await _service.reads().catchError((error) {
      throw Exception("Failed to read users: $error");
    });
  }

  @override
  Future<UserModel> update(UserModel data) async {
    return await _service.update(data).catchError((error) {
      throw Exception("Failed to update user: $error");
    });
  }
}
