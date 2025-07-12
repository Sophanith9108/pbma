// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userstatus_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStatusEnumsAdapter extends TypeAdapter<UserStatusEnums> {
  @override
  final int typeId = 11;

  @override
  UserStatusEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserStatusEnums.active;
      case 1:
        return UserStatusEnums.inactive;
      case 2:
        return UserStatusEnums.pending;
      case 3:
        return UserStatusEnums.blocked;
      case 4:
        return UserStatusEnums.deleted;
      default:
        return UserStatusEnums.active;
    }
  }

  @override
  void write(BinaryWriter writer, UserStatusEnums obj) {
    switch (obj) {
      case UserStatusEnums.active:
        writer.writeByte(0);
        break;
      case UserStatusEnums.inactive:
        writer.writeByte(1);
        break;
      case UserStatusEnums.pending:
        writer.writeByte(2);
        break;
      case UserStatusEnums.blocked:
        writer.writeByte(3);
        break;
      case UserStatusEnums.deleted:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatusEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
