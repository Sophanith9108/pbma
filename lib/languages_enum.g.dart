// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguagesEnumAdapter extends TypeAdapter<LanguagesEnum> {
  @override
  final int typeId = 13;

  @override
  LanguagesEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LanguagesEnum.English;
      case 1:
        return LanguagesEnum.Khmer;
      case 2:
        return LanguagesEnum.Japanese;
      case 3:
        return LanguagesEnum.Chinese;
      default:
        return LanguagesEnum.English;
    }
  }

  @override
  void write(BinaryWriter writer, LanguagesEnum obj) {
    switch (obj) {
      case LanguagesEnum.English:
        writer.writeByte(0);
        break;
      case LanguagesEnum.Khmer:
        writer.writeByte(1);
        break;
      case LanguagesEnum.Japanese:
        writer.writeByte(2);
        break;
      case LanguagesEnum.Chinese:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguagesEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
