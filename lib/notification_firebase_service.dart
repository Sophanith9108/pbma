import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:pbma/core.dart';

class NotificationFirebaseService
    extends AppFirebaseStorageService<NotificationModel> {
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
      .child(AppFirebaseReference.notification);

  @override
  Future<NotificationModel> create(NotificationModel data) async {
    return _database
        .child(data.id)
        .set(NotificationModel.toJson(model: data))
        .then((_) => data);
  }

  @override
  Future<void> delete(String id) async {
    return _database.child(id).remove();
  }

  @override
  Future<NotificationModel> read(String id) async {
    return _database
        .child(id)
        .get()
        .then(
          (snapshot) =>
              snapshot.exists
                  ? NotificationModel.fromJson(
                    json: snapshot.value as Map<dynamic, dynamic>,
                  )
                  : throw Exception('Notification not found'),
        );
  }

  @override
  Future<List<NotificationModel>> reads() async {
    return _database.get().then(
      (snapshot) =>
          snapshot.children
              .map(
                (e) => NotificationModel.fromJson(
                  json: e.value as Map<dynamic, dynamic>,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<NotificationModel> update(NotificationModel data) async {
    return _database
        .child(data.id)
        .update(NotificationModel.toJson(model: data))
        .then((_) => data);
  }
}
