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
  late int? date;
  late int? time;
  late String? location;
  late String? othersInvolved;
  late int? createdAt;
  late int? updatedAt;
  late String? createdBy;
  late String? updatedBy;
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
    int? date,
    int? time,
    String? location,
    String? othersInvolved,
    int? updatedAt,
    String? updatedBy,
    bool? status,
    String? createdBy,
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
    transaction.updatedAt = updatedAt;
    transaction.updatedBy = updatedBy;
    transaction.status = status;
    transaction.createdAt = DateTime.now().millisecondsSinceEpoch;
    transaction.createdBy = createdBy;
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
    entity.createdAt = model.createdAt;
    entity.createdBy = model.createdBy;
    entity.updatedAt = model.updatedAt;
    entity.updatedBy = model.updatedBy;
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
