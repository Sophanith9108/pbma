import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionFirebaseService extends AppRemoteService<TransactionModel> {
  final DatabaseReference database = Get.put(
    FirebaseDatabase.instance
        .ref()
        .child(AppFirebaseReference.root)
        .child(AppFirebaseReference.transaction),
  );

  @override
  Future<void> add(TransactionModel value) async {
    return await database
        .child(value.id)
        .set(TransactionModel.toJson(model: value));
  }

  @override
  Future<void> delete(String key) async {
    return await database.child(key).remove();
  }

  @override
  Future<TransactionModel> read(String key) async {
    var snapshot = await database.child(key).get();
    return TransactionModel.fromJson(
      json: snapshot.value as Map<String, dynamic>,
    );
  }

  @override
  Future<List<TransactionModel>?> reads() async {
    List<TransactionModel> transactions = [];

    DataSnapshot snapshot = await database.get();
    for (var item in snapshot.children) {
      transactions.add(
        TransactionModel.fromJson(json: item.value as Map<dynamic, dynamic>),
      );
    }

    return transactions;
  }

  @override
  Future<void> update(TransactionModel value) async {
    return await database
        .child(value.id)
        .set(TransactionModel.toJson(model: value));
  }
}
