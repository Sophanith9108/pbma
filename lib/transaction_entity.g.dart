// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionEntityAdapter extends TypeAdapter<TransactionEntity> {
  @override
  final int typeId = 0;

  @override
  TransactionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionEntity()
      ..id = fields[0] as String?
      ..purpose = fields[1] as String?
      ..amount = fields[2] as double?
      ..currency = fields[3] as CurrencyEnums?
      ..expenseType = fields[4] as ExpenseTypeEnums?
      ..reason = fields[5] as String?
      ..paymentMethod = fields[6] as PaymentMethodEnums?
      ..isOthersInvolved = fields[7] as bool?
      ..date = fields[8] as DateTime?
      ..time = fields[9] as String?
      ..location = fields[10] as String?
      ..othersInvolved = (fields[11] as List?)?.cast<UserEntity>()
      ..createdAt = fields[12] as DateTime?
      ..updatedAt = fields[13] as DateTime?
      ..createdBy = fields[14] as UserEntity?
      ..updatedBy = fields[15] as UserEntity?
      ..status = fields[16] as TransactionStatusEnums?
      ..latitude = fields[17] as double?
      ..longitude = fields[18] as double?
      ..transactionType = fields[19] as TransactionTypeEnums?
      ..attachments = (fields[20] as List?)?.cast<AttachmentEntity>();
  }

  @override
  void write(BinaryWriter writer, TransactionEntity obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.purpose)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.expenseType)
      ..writeByte(5)
      ..write(obj.reason)
      ..writeByte(6)
      ..write(obj.paymentMethod)
      ..writeByte(7)
      ..write(obj.isOthersInvolved)
      ..writeByte(8)
      ..write(obj.date)
      ..writeByte(9)
      ..write(obj.time)
      ..writeByte(10)
      ..write(obj.location)
      ..writeByte(11)
      ..write(obj.othersInvolved)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.createdBy)
      ..writeByte(15)
      ..write(obj.updatedBy)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.latitude)
      ..writeByte(18)
      ..write(obj.longitude)
      ..writeByte(19)
      ..write(obj.transactionType)
      ..writeByte(20)
      ..write(obj.attachments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
