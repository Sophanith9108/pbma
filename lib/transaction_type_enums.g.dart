// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_type_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionTypeEnumsAdapter extends TypeAdapter<TransactionTypeEnums> {
  @override
  final int typeId = 7;

  @override
  TransactionTypeEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionTypeEnums.expense;
      case 1:
        return TransactionTypeEnums.income;
      case 2:
        return TransactionTypeEnums.transfer;
      case 3:
        return TransactionTypeEnums.loan;
      case 4:
        return TransactionTypeEnums.refund;
      case 5:
        return TransactionTypeEnums.investment;
      case 6:
        return TransactionTypeEnums.donation;
      case 7:
        return TransactionTypeEnums.withdrawal;
      case 8:
        return TransactionTypeEnums.deposit;
      case 9:
        return TransactionTypeEnums.payment;
      case 10:
        return TransactionTypeEnums.chargeback;
      case 11:
        return TransactionTypeEnums.adjustment;
      default:
        return TransactionTypeEnums.expense;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionTypeEnums obj) {
    switch (obj) {
      case TransactionTypeEnums.expense:
        writer.writeByte(0);
        break;
      case TransactionTypeEnums.income:
        writer.writeByte(1);
        break;
      case TransactionTypeEnums.transfer:
        writer.writeByte(2);
        break;
      case TransactionTypeEnums.loan:
        writer.writeByte(3);
        break;
      case TransactionTypeEnums.refund:
        writer.writeByte(4);
        break;
      case TransactionTypeEnums.investment:
        writer.writeByte(5);
        break;
      case TransactionTypeEnums.donation:
        writer.writeByte(6);
        break;
      case TransactionTypeEnums.withdrawal:
        writer.writeByte(7);
        break;
      case TransactionTypeEnums.deposit:
        writer.writeByte(8);
        break;
      case TransactionTypeEnums.payment:
        writer.writeByte(9);
        break;
      case TransactionTypeEnums.chargeback:
        writer.writeByte(10);
        break;
      case TransactionTypeEnums.adjustment:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
