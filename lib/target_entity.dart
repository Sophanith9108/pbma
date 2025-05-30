import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

part 'target_entity.g.dart';

@HiveType(typeId: 9)
class TargetEntity extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late UserEntity user;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  late DateTime updatedAt;

  TargetEntity();

  TargetEntity.create({
    String? id,
    required this.amount,
    required this.user,
    DateTime? updatedAt,
  }) {
    TargetEntity()
      ..id = id ?? Uuid().v8()
      ..amount = amount
      ..user = user
      ..createdAt = createdAt
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static TargetModel toModel({required TargetEntity entity}) {
    return TargetModel()
      ..id = entity.id
      ..amount = entity.amount
      ..user = UserEntity.toModel(entity.user)
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }

  @override
  String toString() {
    return 'TargetEntity{id: $id, amount: $amount, user: $user, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
