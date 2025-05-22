// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_type_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseTypeEnumsAdapter extends TypeAdapter<ExpenseTypeEnums> {
  @override
  final int typeId = 4;

  @override
  ExpenseTypeEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseTypeEnums.food;
      case 1:
        return ExpenseTypeEnums.transport;
      case 2:
        return ExpenseTypeEnums.entertainment;
      case 3:
        return ExpenseTypeEnums.shopping;
      case 4:
        return ExpenseTypeEnums.health;
      case 5:
        return ExpenseTypeEnums.education;
      case 6:
        return ExpenseTypeEnums.travel;
      case 7:
        return ExpenseTypeEnums.bills;
      case 8:
        return ExpenseTypeEnums.other;
      default:
        return ExpenseTypeEnums.food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseTypeEnums obj) {
    switch (obj) {
      case ExpenseTypeEnums.food:
        writer.writeByte(0);
        break;
      case ExpenseTypeEnums.transport:
        writer.writeByte(1);
        break;
      case ExpenseTypeEnums.entertainment:
        writer.writeByte(2);
        break;
      case ExpenseTypeEnums.shopping:
        writer.writeByte(3);
        break;
      case ExpenseTypeEnums.health:
        writer.writeByte(4);
        break;
      case ExpenseTypeEnums.education:
        writer.writeByte(5);
        break;
      case ExpenseTypeEnums.travel:
        writer.writeByte(6);
        break;
      case ExpenseTypeEnums.bills:
        writer.writeByte(7);
        break;
      case ExpenseTypeEnums.other:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTypeEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
