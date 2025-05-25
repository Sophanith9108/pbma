import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

class UserService extends AppStorageRepository<UserEntity> {
  final Box<UserEntity> userBox = Hive.box<UserEntity>(AppStorageBox.userBox);

  @override
  Future<void> delete(String key) async {
    return userBox.delete(key);
  }

  @override
  Future<UserEntity?> get(String key) async {
    return userBox.get(key);
  }

  @override
  Future<List<UserEntity>?> gets() async {
    return userBox.values.toList();
  }

  @override
  Future<void> save(UserEntity value) async {
    return userBox.put(value.id, value);
  }

  @override
  Future<void> update(UserEntity value) async {
    return userBox.put(value.id, value);
  }
}
