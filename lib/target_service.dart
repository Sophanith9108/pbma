import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';

class TargetService extends AppStorageService<TargetEntity> {
  Box<TargetEntity> get _targetBox {
    final boxName =
        kDebugMode
            ? 'debug_${AppStorageBox.targetBox}'
            : kProfileMode
            ? 'profile_${AppStorageBox.targetBox}'
            : AppStorageBox.targetBox;
    return Get.put(Hive.box<TargetEntity>(boxName));
  }

  @override
  Future<void> create(TargetEntity value) async {
    return _targetBox.put(value.id, value);
  }

  @override
  Future<void> delete(String key) async {
    return _targetBox.delete(key);
  }

  @override
  Future<TargetEntity?> read(String key) async {
    return _targetBox.get(key);
  }

  @override
  Future<List<TargetEntity>?> reads() async {
    return _targetBox.values.toList();
  }

  @override
  Future<void> update(TargetEntity value) async {
    return _targetBox.put(value.id, value);
  }
}
