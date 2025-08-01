import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:pbma/core.dart';

class ForgetPasswordService extends AppFirebaseStorageService<UserModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(
        kDebugMode
            ? AppFirebaseReference.devNode
            : kProfileMode
            ? AppFirebaseReference.preNode
            : AppFirebaseReference.proNode,
      )
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.user);

  @override
  Future<UserModel> create(UserModel data) async {
    return await _database
        .child(data.id)
        .set(UserModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception('Failed to create user: $error');
        });
  }

  @override
  Future<void> delete(String id) async {
    return await _database.child(id).remove().catchError((error) {
      throw Exception('Failed to delete user: $error');
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
              json: snapshot.value as Map<String, dynamic>,
            );
          } else {
            throw Exception('User not found');
          }
        })
        .catchError((error) {
          throw Exception('Failed to read user: $error');
        });
  }

  @override
  Future<List<UserModel>> reads() async {
    return await _database.get().then((snapshot) {
      if (snapshot.exists) {
        final List<UserModel> users = [];
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          users.add(UserModel.fromJson(json: value as Map<dynamic, dynamic>));
        });
        return users;
      } else {
        return [];
      }
    });
  }

  @override
  Future<UserModel> update(UserModel data) async {
    return await _database
        .child(data.id)
        .set(UserModel.toJson(model: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception('Failed to update user: $error');
        });
  }
}
