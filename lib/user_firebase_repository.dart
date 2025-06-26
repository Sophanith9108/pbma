import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class UserFirebaseRepository extends AppFirebaseStorageRepository<UserModel> {
  final UserFirebaseService _service = Get.put(UserFirebaseService());

  @override
  Future<UserModel> create(UserModel data) async {
    return await _service
        .create(data)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to create user: $error"),
        );
  }

  @override
  Future<void> delete(String id) async {
    return await _service
        .delete(id)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to delete user: $error"),
        );
  }

  @override
  Future<UserModel> read(String id) async {
    return await _service
        .read(id)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to read user: $error"),
        );
  }

  @override
  Future<List<UserModel>> reads() async {
    return await _service.reads().then(
      (value) => value,
      onError: (error) {
        debugPrint("Failed to read users: $error");
        return <UserModel>[];
      },
    );
  }

  @override
  Future<UserModel> update(UserModel data) async {
    return await _service
        .update(data)
        .then(
          (value) => value,
          onError: (error) => throw Exception("Failed to update user: $error"),
        );
  }
}
