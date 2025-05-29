import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_type_enums.g.dart';

@HiveType(typeId: 7)
enum TransactionTypeEnums {
  @HiveField(0)
  expense,

  @HiveField(1)
  income,

  @HiveField(2)
  transfer,

  @HiveField(3)
  loan,

  @HiveField(4)
  refund,

  @HiveField(5)
  investment,

  @HiveField(6)
  donation,

  @HiveField(7)
  withdrawal,

  @HiveField(8)
  deposit,

  @HiveField(9)
  payment,

  @HiveField(10)
  chargeback,

  @HiveField(11)
  adjustment,
}

extension TransactionTypeEnumsExtension on TransactionTypeEnums {
  String get name {
    switch (this) {
      case TransactionTypeEnums.expense:
        return 'Expense';
      case TransactionTypeEnums.income:
        return 'Income';
      case TransactionTypeEnums.transfer:
        return 'Transfer';
      case TransactionTypeEnums.loan:
        return 'Loan';
      case TransactionTypeEnums.refund:
        return 'Refund';
      case TransactionTypeEnums.investment:
        return 'Investment';
      case TransactionTypeEnums.donation:
        return 'Donation';
      case TransactionTypeEnums.withdrawal:
        return 'Withdrawal';
      case TransactionTypeEnums.deposit:
        return 'Deposit';
      case TransactionTypeEnums.payment:
        return 'Payment';
      case TransactionTypeEnums.chargeback:
        return 'Chargeback';
      case TransactionTypeEnums.adjustment:
        return 'Adjustment';
    }
  }
}
