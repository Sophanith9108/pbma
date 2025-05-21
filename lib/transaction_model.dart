import 'package:equatable/equatable.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class TransactionModel extends Equatable {
  late String? id;
  late String? purpose;
  late double? amount;
  late CurrencyEnums? currency;
  late ExpenseTypeEnums? expenseType;
  late String? reason;
  late PaymentMethodEnums? paymentMethod;
  late bool? isOthersInvolved;
  late DateTime? date;
  late int? time;
  late String? location;
  late String? othersInvolved;
  late DateTime? createdAt;
  late DateTime? updatedAt;
  late UserModel? createdBy;
  late UserModel? updatedBy;
  late bool? status;

  TransactionModel();

  factory TransactionModel.create({
    String? purpose,
    double? amount,
    CurrencyEnums? currency,
    ExpenseTypeEnums? expenseType,
    String? reason,
    PaymentMethodEnums? paymentMethod,
    bool? isOthersInvolved,
    DateTime? date,
    int? time,
    String? location,
    String? othersInvolved,
    UserModel? createdBy,
    UserModel? updatedBy,
    DateTime? updatedAt,
    bool? status,
  }) {
    var transaction = TransactionModel();
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
    transaction.othersInvolved = othersInvolved;
    transaction.createdAt = DateTime.now();
    transaction.createdBy = createdBy;
    transaction.updatedAt = updatedAt ?? DateTime.now();
    transaction.updatedBy = updatedBy;
    transaction.status = status;
    return transaction;
  }

  static TransactionEntity toEntity(TransactionModel model) {
    var entity = TransactionEntity();
    entity.id = model.id;
    entity.purpose = model.purpose;
    entity.amount = model.amount;
    entity.currency = model.currency;
    entity.expenseType = model.expenseType;
    entity.reason = model.reason;
    entity.paymentMethod = model.paymentMethod;
    entity.isOthersInvolved = model.isOthersInvolved;
    entity.date = model.date;
    entity.time = model.time;
    entity.location = model.location;
    entity.othersInvolved = model.othersInvolved;
    entity.createdBy = UserModel.toEntity(model.createdBy!);
    entity.updatedBy = UserModel.toEntity(model.updatedBy!);
    entity.createdAt = model.createdAt;
    entity.updatedAt = model.updatedAt;
    entity.status = model.status;
    return entity;
  }

  @override
  List<Object?> get props => [
    id,
    purpose,
    amount,
    currency,
    expenseType,
    reason,
    paymentMethod,
    isOthersInvolved,
    date,
    time,
    location,
    othersInvolved,
    createdAt,
    updatedAt,
    createdBy,
    updatedBy,
    status,
  ];
}
