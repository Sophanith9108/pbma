import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

class MemberService extends AppStorageService<UserEntity> {
  Box<UserEntity> get _memberBox {
    final boxName =
        kDebugMode
            ? 'debug_${AppStorageBox.memberBox}'
            : kProfileMode
            ? 'profile_${AppStorageBox.memberBox}'
            : AppStorageBox.memberBox;
    return Get.put(Hive.box<UserEntity>(boxName));
  }

  @override
  Future<void> create(UserEntity value) async {
    return _memberBox.put(value.id, value);
  }

  @override
  Future<void> delete(String key) async {
    return _memberBox.delete(key);
  }

  @override
  Future<UserEntity?> read(String key) async {
    return _memberBox.get(key);
  }

  @override
  Future<List<UserEntity>?> reads() async {
    return _memberBox.values.toList();
  }

  @override
  Future<void> update(UserEntity value) async {
    return _memberBox.put(value.id, value);
  }
}
