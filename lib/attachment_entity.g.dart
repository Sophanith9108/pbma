// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentEntityAdapter extends TypeAdapter<AttachmentEntity> {
  @override
  final int typeId = 15;

  @override
  AttachmentEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttachmentEntity()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..image = fields[2] as String?
      ..type = fields[3] as String?
      ..size = fields[4] as String?
      ..createdBy = fields[5] as UserEntity?
      ..createdAt = fields[6] as DateTime?
      ..updatedAt = fields[7] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, AttachmentEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.createdBy)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
