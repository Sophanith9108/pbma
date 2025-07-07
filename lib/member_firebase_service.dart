import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:pbma/core.dart';

class MemberFirebaseService extends AppFirebaseStorageService<MemberModel> {
  final _database = FirebaseDatabase.instance
      .ref()
      .child(
        kDebugMode
            ? AppFirebaseReference.devNode
            : kProfileMode
            ? AppFirebaseReference.preNode
            : AppFirebaseReference.proNode,
      )
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.member);

  @override
  Future<MemberModel> create(MemberModel data) async {
    return await _database
        .child(data.id)
        .set(MemberModel.toJson(member: data))
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
  Future<MemberModel> read(String id) async {
    return await _database
        .child(id)
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            return MemberModel.fromJson(
              json: snapshot.value as Map<dynamic, dynamic>,
            );
          } else {
            throw Exception("Member not found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read member: $error");
        });
  }

  @override
  Future<List<MemberModel>> reads() async {
    return await _database
        .get()
        .then((snapshot) {
          if (snapshot.exists) {
            final dataMap = snapshot.value as Map<dynamic, dynamic>;
            return dataMap.values
                .map((item) => MemberModel.fromJson(json: item))
                .toList();
          } else {
            throw Exception("No member found");
          }
        })
        .catchError((error) {
          throw Exception("Failed to read members: $error");
        });
  }

  @override
  Future<MemberModel> update(MemberModel data) async {
    return await _database
        .child(data.id)
        .set(MemberModel.toJson(member: data))
        .then((_) => data)
        .catchError((error) {
          throw Exception("Failed to update member: $error");
        });
  }
}
