// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentMethodEnumsAdapter extends TypeAdapter<PaymentMethodEnums> {
  @override
  final int typeId = 5;

  @override
  PaymentMethodEnums read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentMethodEnums.cash;
      case 1:
        return PaymentMethodEnums.creditCard;
      case 2:
        return PaymentMethodEnums.debitCard;
      case 3:
        return PaymentMethodEnums.bankTransfer;
      case 4:
        return PaymentMethodEnums.mobilePayment;
      case 5:
        return PaymentMethodEnums.cryptocurrency;
      case 6:
        return PaymentMethodEnums.check;
      case 7:
        return PaymentMethodEnums.giftCard;
      case 8:
        return PaymentMethodEnums.invoice;
      case 9:
        return PaymentMethodEnums.contactlessPayment;
      case 10:
        return PaymentMethodEnums.digitalWallet;
      case 11:
        return PaymentMethodEnums.buyNowPayLater;
      case 12:
        return PaymentMethodEnums.prepaidCard;
      case 13:
        return PaymentMethodEnums.loyaltyPoints;
      case 14:
        return PaymentMethodEnums.bartering;
      default:
        return PaymentMethodEnums.cash;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentMethodEnums obj) {
    switch (obj) {
      case PaymentMethodEnums.cash:
        writer.writeByte(0);
        break;
      case PaymentMethodEnums.creditCard:
        writer.writeByte(1);
        break;
      case PaymentMethodEnums.debitCard:
        writer.writeByte(2);
        break;
      case PaymentMethodEnums.bankTransfer:
        writer.writeByte(3);
        break;
      case PaymentMethodEnums.mobilePayment:
        writer.writeByte(4);
        break;
      case PaymentMethodEnums.cryptocurrency:
        writer.writeByte(5);
        break;
      case PaymentMethodEnums.check:
        writer.writeByte(6);
        break;
      case PaymentMethodEnums.giftCard:
        writer.writeByte(7);
        break;
      case PaymentMethodEnums.invoice:
        writer.writeByte(8);
        break;
      case PaymentMethodEnums.contactlessPayment:
        writer.writeByte(9);
        break;
      case PaymentMethodEnums.digitalWallet:
        writer.writeByte(10);
        break;
      case PaymentMethodEnums.buyNowPayLater:
        writer.writeByte(11);
        break;
      case PaymentMethodEnums.prepaidCard:
        writer.writeByte(12);
        break;
      case PaymentMethodEnums.loyaltyPoints:
        writer.writeByte(13);
        break;
      case PaymentMethodEnums.bartering:
        writer.writeByte(14);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodEnumsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
