// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenderEnumsAdapter extends TypeAdapter<GenderEnums> {
  @override
  final int typeId = 3;

  @override
  GenderEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GenderEnums.male;
      case 1:
        return GenderEnums.female;
      default:
        return GenderEnums.male;
    }
  }

  @override
  void write(BinaryWriter writer, GenderEnums obj) {
    switch (obj) {
      case GenderEnums.male:
        writer.writeByte(0);
        break;
      case GenderEnums.female:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
