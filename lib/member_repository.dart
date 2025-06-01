import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberRepository extends AppStorageRepository<UserModel> {
  final MemberService _service = Get.put(MemberService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<UserModel?> get(String key) async {
    var value = await _service.read(key);
    return value != null ? UserEntity.toModel(value) : null;
  }

  @override
  Future<List<UserModel>?> gets() async {
    var values = await _service.reads();
    return values?.map((e) => UserEntity.toModel(e)).toList();
  }

  @override
  Future<void> save(UserModel value) async {
    return _service.create(UserModel.toEntity(value));
  }

  @override
  Future<void> update(UserModel value) async {
    return _service.update(UserModel.toEntity(value));
  }
}
