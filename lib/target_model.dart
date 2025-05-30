import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class TargetModel extends Equatable {
  final _id = Uuid().v8().obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _amount = 0.0.obs;
  double get amount => _amount.value;
  set amount(double value) => _amount.value = value;

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  TargetModel();

  factory TargetModel.create({
    String? id,
    required double amount,
    required UserModel user,
    DateTime? updatedAt,
  }) {
    return TargetModel()
      ..id = id ?? Uuid().v8()
      ..amount = amount
      ..user = user
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static TargetEntity toEntity({required TargetModel model}) {
    return TargetEntity()
      ..id = model.id
      ..amount = model.amount
      ..user = UserModel.toEntity(model.user)
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt;
  }

  @override
  List<Object?> get props => [id, amount, user, createdAt, updatedAt];
}
