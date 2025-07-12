// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 1;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..email = fields[2] as String?
      ..phone = fields[3] as String?
      ..password = fields[4] as String?
      ..profilePicture = fields[5] as String?
      ..address = fields[6] as String?
      ..dateOfBirth = fields[7] as String?
      ..gender = fields[8] as GenderEnums?
      ..createdAt = fields[9] as DateTime?
      ..updatedAt = fields[10] as DateTime?
      ..role = fields[11] as UserRoleEnums
      ..isLogin = fields[12] as bool
      ..deviceId = fields[13] as String?
      ..deviceToken = fields[14] as String?
      ..deviceInfo = fields[15] as String?
      ..enableBiometric = fields[16] as bool
      ..status = fields[17] as UserStatusEnums;
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.dateOfBirth)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.role)
      ..writeByte(12)
      ..write(obj.isLogin)
      ..writeByte(13)
      ..write(obj.deviceId)
      ..writeByte(14)
      ..write(obj.deviceToken)
      ..writeByte(15)
      ..write(obj.deviceInfo)
      ..writeByte(16)
      ..write(obj.enableBiometric)
      ..writeByte(17)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
