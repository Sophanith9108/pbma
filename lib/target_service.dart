import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';

class TargetService extends AppStorageService<TargetEntity> {
  final Box<TargetEntity> _targetBox = Get.put(
    Hive.box<TargetEntity>(AppStorageBox.targetBox),
  );

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
