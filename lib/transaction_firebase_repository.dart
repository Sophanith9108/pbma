import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionFirebaseRepository
    extends AppFirebaseStorageRepository<TransactionModel> {
  final TransactionFirebaseService _service = Get.put(
    TransactionFirebaseService(),
  );

  @override
  Future<TransactionModel> create(TransactionModel data) async {
    return await _service
        .create(data)
        .then(
          (value) => value,
          onError:
              (error) =>
                  throw Exception("Failed to create transaction: $error"),
        );
  }

  @override
  Future<void> delete(String id) async {
    return await _service
        .delete(id)
        .then(
          (value) => value,
          onError:
              (error) =>
                  throw Exception("Failed to delete transaction: $error"),
        );
  }

  @override
  Future<TransactionModel> read(String id) async {
    return await _service
        .read(id)
        .then(
          (value) => value,
          onError:
              (error) => throw Exception("Failed to read transaction: $error"),
        );
  }

  @override
  Future<List<TransactionModel>> reads() async {
    return await _service.reads().then(
      (value) => value,
      onError: (error) {
        debugPrint("Failed to read transactions: $error");
        return <TransactionModel>[];
      },
    );
  }

  @override
  Future<TransactionModel> update(TransactionModel data) async {
    return await _service
        .update(data)
        .then(
          (value) => value,
          onError:
              (error) =>
                  throw Exception("Failed to update transaction: $error"),
        );
  }
}
