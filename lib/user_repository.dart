import 'package:get/get.dart';
import 'package:pbma/core.dart';

class UserRepository extends AppStorageRepository<UserModel> {
  final UserService _service = Get.put(UserService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<UserModel?> get(String key) async {
    final UserEntity? entity = await _service.get(key);
    return entity != null ? UserEntity.toModel(entity) : null;
  }

  @override
  Future<List<UserModel>?> gets() async {
    final List<UserEntity>? entities = await _service.gets();
    return entities?.map((e) => UserEntity.toModel(e)).toList();
  }

  @override
  Future<void> save(UserModel value) async {
    return _service.save(UserModel.toEntity(value));
  }

  @override
  Future<void> update(UserModel value) async {
    return _service.update(UserModel.toEntity(value));
  }
}
