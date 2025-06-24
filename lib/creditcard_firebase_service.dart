import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class CreditCardFirebaseService
    extends AppFirebaseStorageService<CreditCardModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref(AppFirebaseReference.root)
      .child(AppFirebaseReference.creditCard);

  @override
  Future<CreditCardModel> create(CreditCardModel data) async {
    return await _database
        .child(data.id)
        .set(CreditCardModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to create credit card: $error");
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _database.child(id).remove().catchError((error) {
      throw Exception("Failed to delete credit card: $error");
    });
  }

  @override
  Future<CreditCardModel> read(String id) async {
    return await _database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return CreditCardModel.fromJson(
              json: snapshot.value as Map<dynamic, dynamic>,
            );
          } else {
            throw Exception("Credit card not found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read credit card: $error");
        });
  }

  @override
  Future<List<CreditCardModel>> reads() async {
    return await _database
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return (snapshot.value as List<dynamic>)
                .map(
                  (item) => CreditCardModel.fromJson(
                    json: item as Map<dynamic, dynamic>,
                  ),
                )
                .toList();
          } else {
            throw Exception("No credit cards found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read credit cards: $error");
        });
  }

  @override
  Future<CreditCardModel> update(CreditCardModel data) async {
    return await _database
        .child(data.id)
        .update(CreditCardModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to update credit card: $error");
        });
  }
}
