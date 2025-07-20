// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsEntityAdapter extends TypeAdapter<SettingsEntity> {
  @override
  final int typeId = 12;

  @override
  SettingsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsEntity()
      ..id = fields[0] as String
      ..language = fields[1] as LanguagesEnum
      ..theme = fields[2] as String
      ..enableNotification = fields[3] as bool
      ..createdBy = fields[4] as UserEntity
      ..createdAt = fields[5] as DateTime
      ..updatedAt = fields[6] as DateTime;
  }

  @override
  void write(BinaryWriter writer, SettingsEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.theme)
      ..writeByte(3)
      ..write(obj.enableNotification)
      ..writeByte(4)
      ..write(obj.createdBy)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
