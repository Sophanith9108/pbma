import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

part 'budget_entity.g.dart';

@HiveType(typeId: 10)
class BudgetEntity extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late double amount;

  @HiveField(3)
  late CurrencyEnums currency;

  @HiveField(4)
  late String purpose;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late DateTime updatedAt;

  @HiveField(7)
  late DateTime date;

  BudgetEntity();

  factory BudgetEntity.create({
    String? id,
    required String name,
    required double amount,
    required CurrencyEnums currency,
    required String purpose,
    required DateTime dart,
    DateTime? updatedAt,
  }) {
    return BudgetEntity()
      ..id = id ?? Uuid().v8()
      ..name = name
      ..amount = amount
      ..currency = currency
      ..purpose = purpose
      ..date = dart
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static BudgetModel toModel({required BudgetEntity entity}) {
    return BudgetModel()
      ..id = entity.id
      ..name = entity.name
      ..amount = entity.amount
      ..currency = entity.currency
      ..purpose = entity.purpose
      ..date = entity.date
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }
}
