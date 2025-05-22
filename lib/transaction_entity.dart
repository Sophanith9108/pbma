import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

part 'transaction_entity.g.dart';

@HiveType(typeId: 0)
class TransactionEntity extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? purpose;

  @HiveField(2)
  double? amount;

  @HiveField(3)
  CurrencyEnums? currency;

  @HiveField(4)
  ExpenseTypeEnums? expenseType;

  @HiveField(5)
  String? reason;

  @HiveField(6)
  PaymentMethodEnums? paymentMethod;

  @HiveField(7)
  bool? isOthersInvolved;

  @HiveField(8)
  String? date;

  @HiveField(9)
  String? time;

  @HiveField(10)
  String? location;

  @HiveField(11)
  String? othersInvolved;

  @HiveField(12)
  DateTime? createdAt;

  @HiveField(13)
  DateTime? updatedAt;

  @HiveField(14)
  UserEntity? createdBy;

  @HiveField(15)
  UserEntity? updatedBy;

  @HiveField(16)
  TransactionStatusEnums? status;

  @HiveField(17)
  double? latitude;

  @HiveField(18)
  double? longitude;

  TransactionEntity();

  factory TransactionEntity.create({
    String? purpose,
    double? amount,
    CurrencyEnums? currency,
    ExpenseTypeEnums? expenseType,
    String? reason,
    PaymentMethodEnums? paymentMethod,
    bool? isOthersInvolved,
    String? date,
    String? time,
    String? location,
    double? latitude,
    double? longitude,
    String? othersInvolved,
    DateTime? updatedAt,
    UserEntity? createdBy,
    UserEntity? updatedBy,
    TransactionStatusEnums? status,
  }) {
    var transaction = TransactionEntity();
    transaction.id = Uuid().v8();
    transaction.purpose = purpose;
    transaction.amount = amount;
    transaction.currency = currency;
    transaction.expenseType = expenseType;
    transaction.reason = reason;
    transaction.paymentMethod = paymentMethod;
    transaction.isOthersInvolved = isOthersInvolved;
    transaction.date = date;
    transaction.time = time;
    transaction.location = location;
    transaction.latitude = latitude;
    transaction.longitude = longitude;
    transaction.othersInvolved = othersInvolved;
    transaction.createdAt = DateTime.now();
    transaction.createdBy = createdBy;
    transaction.updatedAt = updatedAt ?? DateTime.now();
    transaction.updatedBy = updatedBy;
    transaction.status = status;
    return transaction;
  }

  static TransactionModel toModel(TransactionEntity entity) {
    var model = TransactionModel();
    model.id = entity.id;
    model.purpose = entity.purpose;
    model.amount = entity.amount;
    model.currency = entity.currency;
    model.expenseType = entity.expenseType;
    model.reason = entity.reason;
    model.paymentMethod = entity.paymentMethod;
    model.isOthersInvolved = entity.isOthersInvolved;
    model.date = entity.date;
    model.time = entity.time;
    model.location = entity.location;
    model.latitude = entity.latitude ?? 0.0;
    model.longitude = entity.longitude ?? 0.0;
    model.othersInvolved = entity.othersInvolved;
    model.createdAt = entity.createdAt;
    model.updatedAt = entity.updatedAt;
    model.createdBy = UserEntity.toModel(entity.createdBy!);
    model.updatedBy = UserEntity.toModel(entity.updatedBy!);
    model.status = entity.status;
    return model;
  }
}
