import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class BudgetFirebaseService extends AppRemoteService<BudgetModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.budget);

  @override
  Future<void> add(BudgetModel value) async {
    return _database.child(value.id).set(BudgetModel.toJson(model: value));
  }

  @override
  Future<void> delete(String key) async {
    return _database.child(key).remove();
  }

  @override
  Future<BudgetModel> read(String key) async {
    return _database
        .child(key)
        .get()
        .then(
          (snapshot) => BudgetModel.fromJson(
            json: snapshot.value as Map<dynamic, dynamic>,
          ),
        );
  }

  @override
  Future<List<BudgetModel>?> reads() async {
    return _database.get().then(
      (snapshot) =>
          snapshot.children
              .map(
                (e) => BudgetModel.fromJson(
                  json: e.value as Map<dynamic, dynamic>,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<void> update(BudgetModel value) async {
    return _database.child(value.id).update(BudgetModel.toJson(model: value));
  }
}
