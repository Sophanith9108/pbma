import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionFirebaseService extends AppRemoteService<TransactionModel> {
  final DatabaseReference database = Get.put(
    FirebaseDatabase.instance.ref(AppFirebaseReference.devNode),
  );

  @override
  Future<void> create(TransactionModel value) async {
    var ref = database.child(AppFirebaseReference.transaction);
    await ref.push().set(TransactionModel.toJson(model: value));
  }

  @override
  Future<void> delete(String key) async {
    var ref = database.child(AppFirebaseReference.transaction);
    await ref.child(key).remove();
  }

  @override
  Future<TransactionModel> read(String key) async {
    var ref = database.child(AppFirebaseReference.transaction);
    var snapshot = await ref.child(key).get();
    return TransactionModel.fromMap(
      json: snapshot.value as Map<String, dynamic>,
    );
  }

  @override
  Future<List<TransactionModel>?> reads() async {
    var ref = database.child(AppFirebaseReference.transaction);
    var snapshot = await ref.get();
    return snapshot.children
        .map(
          (e) =>
              TransactionModel.fromMap(json: e.value as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> update(TransactionModel value) async {
    var ref = database.child(AppFirebaseReference.transaction);
    await ref.child(value.id).set(TransactionModel.toJson(model: value));
  }
}
