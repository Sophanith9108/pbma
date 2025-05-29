// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRoleEnumsAdapter extends TypeAdapter<UserRoleEnums> {
  @override
  final int typeId = 8;

  @override
  UserRoleEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserRoleEnums.super_admin;
      case 1:
        return UserRoleEnums.admin;
      case 2:
        return UserRoleEnums.user;
      default:
        return UserRoleEnums.super_admin;
    }
  }

  @override
  void write(BinaryWriter writer, UserRoleEnums obj) {
    switch (obj) {
      case UserRoleEnums.super_admin:
        writer.writeByte(0);
        break;
      case UserRoleEnums.admin:
        writer.writeByte(1);
        break;
      case UserRoleEnums.user:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
