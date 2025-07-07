import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

class TransactionService extends AppStorageService<TransactionEntity> {
  Box<TransactionEntity> get _transactionBox {
    final boxName =
        kDebugMode
            ? 'debug_${AppStorageBox.transactionBox}'
            : kProfileMode
            ? 'profile_${AppStorageBox.transactionBox}'
            : AppStorageBox.transactionBox;
    return Get.put(Hive.box<TransactionEntity>(boxName));
  }

  @override
  Future<void> create(TransactionEntity value) async {
    return _transactionBox.put(value.id, value);
  }

  @override
  Future<TransactionEntity?> read(String key) async {
    return _transactionBox.get(key);
  }

  @override
  Future<List<TransactionEntity>?> reads() async {
    return _transactionBox.values.toList();
  }

  @override
  Future<void> update(TransactionEntity value) async {
    return _transactionBox.put(value.id, value);
  }

  @override
  Future<void> delete(String key) async {
    return _transactionBox.delete(key);
  }
}
