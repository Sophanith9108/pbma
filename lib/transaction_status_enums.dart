import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_status_enums.g.dart';

@HiveType(typeId: 6)
enum TransactionStatusEnums {
  @HiveField(0)
  pending,

  @HiveField(1)
  success,

  @HiveField(2)
  failed,
}

extension TransactionStatusEnumsExtension on TransactionStatusEnums {
  String get name {
    switch (this) {
      case TransactionStatusEnums.pending:
        return 'Pending';
      case TransactionStatusEnums.success:
        return 'Success';
      case TransactionStatusEnums.failed:
        return 'Failed';
    }
  }
}
