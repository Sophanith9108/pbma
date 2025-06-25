import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class TransactionFirebaseService
    extends AppFirebaseStorageService<TransactionModel> {
  final DatabaseReference database = FirebaseDatabase.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.transaction);

  @override
  Future<TransactionModel> create(TransactionModel data) async {
    return await database
        .push()
        .child(data.id)
        .set(TransactionModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to create transaction: $error");
        });
  }

  @override
  Future<void> delete(String id) async {
    return await database.child(id).remove().catchError((error) {
      throw Exception("Failed to delete transaction: $error");
    });
  }

  @override
  Future<TransactionModel> read(String id) async {
    return await database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return TransactionModel.fromJson(
              json: snapshot.value as Map<dynamic, dynamic>,
            );
          } else {
            throw Exception("Transaction not found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read transaction: $error");
        });
  }

  @override
  Future<List<TransactionModel>> reads() async {
    return await database
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return (snapshot.value as List<dynamic>)
                .map((item) => TransactionModel.fromJson(json: item))
                .toList();
          } else {
            throw Exception("No transactions found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read transactions: $error");
        });
  }

  @override
  Future<TransactionModel> update(TransactionModel data) async {
    return await database
        .child(data.id)
        .set(TransactionModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to update transaction: $error");
        });
  }
}
