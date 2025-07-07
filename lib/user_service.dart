import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

class UserService extends AppStorageRepository<UserEntity> {
  Box<UserEntity> get userBox {
    final boxName =
        kDebugMode
            ? 'debug_${AppStorageBox.userBox}'
            : kProfileMode
            ? 'profile_${AppStorageBox.userBox}'
            : AppStorageBox.userBox;
    return Hive.box<UserEntity>(boxName);
  }

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
