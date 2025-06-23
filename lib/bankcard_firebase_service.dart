import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class BankCardFirebaseService extends AppFirebaseStorageService<BankCardModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.bankCard);

  @override
  Future<BankCardModel> create(BankCardModel data) async {
    return await _database
        .child(data.id)
        .set(BankCardModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception('Failed to create bank card: $error');
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _database.child(id).remove().catchError((error) {
      throw Exception('Failed to delete bank card: $error');
    });
  }

  @override
  Future<BankCardModel> read(String id) async {
    return await _database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return BankCardModel.fromJson(
              json: snapshot.value as Map<String, dynamic>,
            );
          } else {
            throw Exception('Bank card not found');
          }
        })
        .catchError((error) {
          throw Exception('Failed to read bank card: $error');
        });
  }

  @override
  Future<List<BankCardModel>> reads() async {
    return await _database.get().then((snapshot) {
      if (snapshot.exists) {
        final List<BankCardModel> bankCards = [];
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          bankCards.add(
            BankCardModel.fromJson(json: value as Map<dynamic, dynamic>),
          );
        });
        return bankCards;
      } else {
        return [];
      }
    });
  }

  @override
  Future<BankCardModel> update(BankCardModel data) async {
    return await _database
        .child(data.id)
        .set(BankCardModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception('Failed to update bank card: $error');
        });
  }
}
