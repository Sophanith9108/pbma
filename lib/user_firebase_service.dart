import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class UserFirebaseService extends AppFirebaseStorageService<UserModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.user);

  @override
  Future<UserModel> create(UserModel data) async {
    return await _database
        .push()
        .child(data.id)
        .set(UserModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to create user: $error");
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _database.child(id).remove().catchError((error) {
      throw Exception("Failed to delete user: $error");
    });
  }

  @override
  Future<UserModel> read(String id) async {
    return await _database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return UserModel.fromJson(
              json: snapshot.value as Map<dynamic, dynamic>,
            );
          } else {
            throw Exception("User not found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read user: $error");
        });
  }

  @override
  Future<List<UserModel>> reads() async {
    return await _database
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return (snapshot.value as List<dynamic>)
                .map((item) => UserModel.fromJson(json: item))
                .toList();
          } else {
            throw Exception("No users found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read users: $error");
        });
  }

  @override
  Future<UserModel> update(UserModel data) async {
    return await _database
        .child(data.id)
        .set(UserModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to update user: $error");
        });
  }
}
