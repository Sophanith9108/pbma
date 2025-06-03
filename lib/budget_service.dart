import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';

class BudgetService extends AppStorageService<BudgetEntity> {
  final Box<BudgetEntity> _budgetBox = Get.put(
    Hive.box<BudgetEntity>(AppStorageBox.budgetBox),
  );

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
