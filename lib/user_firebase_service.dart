import 'package:firebase_database/firebase_database.dart';
import 'package:pbma/core.dart';

class UserFirebaseService extends AppRemoteService<UserModel> {
  final DatabaseReference _database = FirebaseDatabase.instance
      .ref()
      .child(AppFirebaseReference.root)
      .child(AppFirebaseReference.user);

  @override
  Future<void> add(UserModel value) async {
    return _database.child(value.id).set(UserModel.toJson(model: value));
  }

  @override
  Future<void> delete(String key) async {
    return _database.child(key).remove();
  }

  @override
  Future<UserModel> read(String key) async {
    return UserModel.fromJson(
      json: (await _database.child(key).get()).value as Map<dynamic, dynamic>,
    );
  }

  @override
  Future<List<UserModel>?> reads() async {
    return _database.get().then(
      (snapshot) =>
          snapshot.children
              .map(
                (e) =>
                    UserModel.fromJson(json: e.value as Map<dynamic, dynamic>),
              )
              .toList(),
    );
  }

  @override
  Future<void> update(UserModel value) async {
    return _database.child(value.id).update(UserModel.toJson(model: value));
  }
}
