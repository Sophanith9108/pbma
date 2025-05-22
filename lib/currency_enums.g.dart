// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyEnumsAdapter extends TypeAdapter<CurrencyEnums> {
  @override
  final int typeId = 2;

  @override
  CurrencyEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CurrencyEnums.USD;
      case 1:
        return CurrencyEnums.KHR;
      default:
        return CurrencyEnums.USD;
    }
  }

  @override
  void write(BinaryWriter writer, CurrencyEnums obj) {
    switch (obj) {
      case CurrencyEnums.USD:
        writer.writeByte(0);
        break;
      case CurrencyEnums.KHR:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
