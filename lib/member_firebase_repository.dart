import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberFirebaseRepository
    extends AppFirebaseStorageRepository<MemberModel> {
  final MemberFirebaseService _service = Get.put(MemberFirebaseService());

  @override
  Future<MemberModel> create(MemberModel data) async {
    return await _service
        .create(data)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to create user: $error"),
        );
  }

  @override
  Future<void> delete(String id) async {
    return await _service
        .delete(id)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to delete user: $error"),
        );
  }

  @override
  Future<MemberModel> read(String id) async {
    return await _service
        .read(id)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to read user: $error"),
        );
  }

  @override
  Future<List<MemberModel>> reads() async {
    return await _service.reads().then(
      (value) => value,
      onError: (error) {
        AppUtils.logging(error);
        return <MemberModel>[];
      },
    );
  }

  @override
  Future<MemberModel> update(MemberModel data) async {
    return await _service
        .update(data)
        .then(
          (value) => value,
          onError: (error) {
            AppUtils.logging(error);
            throw Exception("Failed to update user: $error");
          },
        );
  }
}
