// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TargetEntityAdapter extends TypeAdapter<TargetEntity> {
  @override
  final int typeId = 9;

  @override
  TargetEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TargetEntity()
      ..id = fields[0] as String
      ..amount = fields[1] as double
      ..user = fields[2] as UserEntity
      ..createdAt = fields[3] as DateTime
      ..updatedAt = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, TargetEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.user)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
