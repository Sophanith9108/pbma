import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:pbma/core.dart';

class BudgetFirebaseService extends AppFirebaseStorageService<BudgetModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(
        kDebugMode
            ? AppFirebaseReference.devNode
            : AppFirebaseReference.preNode,
      )
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.budget);

  @override
  Future<BudgetModel> create(BudgetModel data) async {
    return await _database
        .child(data.id)
        .set(BudgetModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to create budget: $error");
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _database.child(id).remove().catchError((error) {
      throw Exception("Failed to delete budget: $error");
    });
  }

  @override
  Future<BudgetModel> read(String id) async {
    return await _database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return BudgetModel.fromJson(
              json: snapshot.value as Map<dynamic, dynamic>,
            );
          } else {
            throw Exception("Budget not found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read budget: $error");
        });
  }

  @override
  Future<List<BudgetModel>> reads() async {
    return await _database
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            final data = snapshot.value as Map<dynamic, dynamic>;
            return data.values
                .map((item) => BudgetModel.fromJson(json: item))
                .toList();
          } else {
            throw Exception("No budgets found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read budgets: $error");
        });
  }

  @override
  Future<BudgetModel> update(BudgetModel data) async {
    return await _database
        .child(data.id)
        .set(BudgetModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to update budget: $error");
        });
  }
}
