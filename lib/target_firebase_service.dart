import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class TargetFirebaseService extends AppFirebaseStorageService<TargetModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.target);

  @override
  Future<TargetModel> create(TargetModel data) async {
    return await _database
        .child(data.id)
        .set(TargetModel.toEntity(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to create target: $error");
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _database.child(id).remove().catchError((error) {
      throw Exception("Failed to delete target: $error");
    });
  }

  @override
  Future<TargetModel> read(String id) async {
    return await _database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return TargetModel.fromJson(
              json: snapshot.value as Map<dynamic, dynamic>,
            );
          } else {
            throw Exception("Target not found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read target: $error");
        });
  }

  @override
  Future<List<TargetModel>> reads() async {
    return _database.get().then(
      (snapshot) =>
          snapshot.children
              .map(
                (e) => TargetModel.fromJson(
                  json: e.value as Map<dynamic, dynamic>,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<TargetModel> update(TargetModel data) async {
    return _database
        .child(data.id)
        .update(TargetModel.toJson(model: data))
        .then((_) => data);
  }
}
