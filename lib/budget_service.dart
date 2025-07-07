import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';

class BudgetService extends AppStorageService<BudgetEntity> {
  Box<BudgetEntity> get _budgetBox {
    final boxName =
        kDebugMode
            ? 'debug_${AppStorageBox.budgetBox}'
            : kProfileMode
            ? 'profile_${AppStorageBox.budgetBox}'
            : AppStorageBox.budgetBox;
    return Get.put(Hive.box<BudgetEntity>(boxName));
  }

  @override
  Future<void> create(BudgetEntity value) async {
    return _budgetBox.put(value.id, value);
  }

  @override
  Future<void> delete(String key) async {
    return _budgetBox.delete(key);
  }

  @override
  Future<BudgetEntity?> read(String key) async {
    return _budgetBox.get(key);
  }

  @override
  Future<List<BudgetEntity>?> reads() async {
    return _budgetBox.values.toList();
  }

  @override
  Future<void> update(BudgetEntity value) async {
    return _budgetBox.put(value.id, value);
  }
}
