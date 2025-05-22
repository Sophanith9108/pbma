// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_status_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionStatusEnumsAdapter
    extends TypeAdapter<TransactionStatusEnums> {
  @override
  final int typeId = 6;

  @override
  TransactionStatusEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionStatusEnums.pending;
      case 1:
        return TransactionStatusEnums.success;
      case 2:
        return TransactionStatusEnums.failed;
      default:
        return TransactionStatusEnums.pending;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionStatusEnums obj) {
    switch (obj) {
      case TransactionStatusEnums.pending:
        writer.writeByte(0);
        break;
      case TransactionStatusEnums.success:
        writer.writeByte(1);
        break;
      case TransactionStatusEnums.failed:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionStatusEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
