import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class BudgetFirebaseRepository
    extends AppFirebaseStorageRepository<BudgetModel> {
  final BudgetFirebaseService _service = Get.put(BudgetFirebaseService());

  @override
  Future<BudgetModel> create(BudgetModel data) async {
    return await _service.create(data).catchError((error) {
      throw Exception("Failed to create budget: $error");
    });
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id).catchError((error) {
      throw Exception("Failed to delete budget: $error");
    });
  }

  @override
  Future<BudgetModel> read(String id) async {
    return await _service.read(id).catchError((error) {
      throw Exception("Failed to read budget: $error");
    });
  }

  @override
  Future<List<BudgetModel>> reads() async {
    return await _service.reads().then(
      (value) => value,
      onError: (error) {
        debugPrint("Failed to read budgets: $error");
        return <BudgetModel>[];
      },
    );
  }

  @override
  Future<BudgetModel> update(BudgetModel data) async {
    return await _service.update(data).catchError((error) {
      throw Exception("Failed to update budget: $error");
    });
  }
}
