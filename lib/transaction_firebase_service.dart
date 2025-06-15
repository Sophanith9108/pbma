import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionFirebaseService extends AppRemoteService<TransactionModel> {
  final DatabaseReference database = Get.put(
    FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://pbma-app-default-rtdb.asia-southeast1.firebasedatabase.app/",
    ).ref(AppFirebaseReference.root).child(AppFirebaseReference.devNode),
  );

  @override
  Future<void> add(TransactionModel value) async {
    var ref = database.child(AppFirebaseReference.transaction);
    return await ref.child(value.id).set(TransactionModel.toJson(model: value));
  }

  @override
  Future<void> delete(String key) async {
    var ref = database.child(AppFirebaseReference.transaction);
    return await ref.child(key).remove();
  }

  @override
  Future<TransactionModel> read(String key) async {
    var ref = database.child(AppFirebaseReference.transaction);
    var snapshot = await ref.child(key).get();
    return TransactionModel.fromJson(
      json: snapshot.value as Map<String, dynamic>,
    );
  }

  @override
  Future<List<TransactionModel>?> reads() async {
    var ref = database.child(AppFirebaseReference.transaction);
    var snapshot = await ref.get();
    List<TransactionModel> transactions = [];
    snapshot.children.map((element) {
      element.children.map((transaction) {
        transactions.add(
          TransactionModel.fromJson(
            json: transaction.value as Map<String, dynamic>,
          ),
        );
      });
    });
    return transactions;
  }

  @override
  Future<void> update(TransactionModel value) async {
    var ref = database.child(AppFirebaseReference.transaction);
    return await ref.child(value.id).set(TransactionModel.toJson(model: value));
  }
}
