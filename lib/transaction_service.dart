import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

class TransactionService extends AppStorageService<TransactionEntity> {
  final Box<TransactionEntity> transactionBox = Get.put(
    Hive.box<TransactionEntity>(AppStorageBox.transactionBox),
  );

  @override
  Future<void> create(TransactionEntity value) async {
    return transactionBox.put(value.id, value);
  }

  @override
  Future<TransactionEntity?> read(String key) async {
    return transactionBox.get(key);
  }

  @override
  Future<List<TransactionEntity>?> reads() async {
    return transactionBox.values.toList();
  }

  @override
  Future<void> update(TransactionEntity value) async {
    return transactionBox.put(value.id, value);
  }

  @override
  Future<void> delete(String key) async {
    return transactionBox.delete(key);
  }
}
