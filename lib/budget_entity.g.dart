// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetEntityAdapter extends TypeAdapter<BudgetEntity> {
  @override
  final int typeId = 10;

  @override
  BudgetEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetEntity()
      ..id = fields[0] as String
      ..name = fields[1] as String
      ..amount = fields[2] as double
      ..currency = fields[3] as CurrencyEnums
      ..purpose = fields[4] as String
      ..createdAt = fields[5] as DateTime
      ..updatedAt = fields[6] as DateTime
      ..date = fields[7] as DateTime;
  }

  @override
  void write(BinaryWriter writer, BudgetEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.purpose)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
