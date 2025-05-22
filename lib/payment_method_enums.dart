import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'payment_method_enums.g.dart';

@HiveType(typeId: 5)
enum PaymentMethodEnums {
  @HiveField(0)
  cash,

  @HiveField(1)
  creditCard,

  @HiveField(2)
  debitCard,

  @HiveField(3)
  bankTransfer,

  @HiveField(4)
  mobilePayment,

  @HiveField(5)
  cryptocurrency,

  @HiveField(6)
  check,

  @HiveField(7)
  giftCard,

  @HiveField(8)
  invoice,

  @HiveField(9)
  contactlessPayment,

  @HiveField(10)
  digitalWallet,

  @HiveField(11)
  buyNowPayLater,

  @HiveField(12)
  prepaidCard,

  @HiveField(13)
  loyaltyPoints,

  @HiveField(14)
  bartering,
}

extension PaymentMethodEnumsExtension on PaymentMethodEnums {
  String get name {
    switch (this) {
      case PaymentMethodEnums.cash:
        return 'Cash';
      case PaymentMethodEnums.creditCard:
        return 'Credit Card';
      case PaymentMethodEnums.debitCard:
        return 'Debit Card';
      case PaymentMethodEnums.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethodEnums.mobilePayment:
        return 'Mobile Payment';
      case PaymentMethodEnums.cryptocurrency:
        return 'Cryptocurrency';
      case PaymentMethodEnums.check:
        return 'Check';
      case PaymentMethodEnums.giftCard:
        return 'Gift Card';
      case PaymentMethodEnums.invoice:
        return 'Invoice';
      case PaymentMethodEnums.contactlessPayment:
        return 'Contactless Payment';
      case PaymentMethodEnums.digitalWallet:
        return 'Digital Wallet';
      case PaymentMethodEnums.buyNowPayLater:
        return 'Buy Now Pay Later';
      case PaymentMethodEnums.prepaidCard:
        return 'Prepaid Card';
      case PaymentMethodEnums.loyaltyPoints:
        return 'Loyalty Points';
      case PaymentMethodEnums.bartering:
        return 'Bartering';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethodEnums.cash:
        return Icons.money;
      case PaymentMethodEnums.creditCard:
        return Icons.credit_card;
      case PaymentMethodEnums.debitCard:
        return Icons.account_balance_wallet;
      case PaymentMethodEnums.bankTransfer:
        return Icons.account_balance;
      case PaymentMethodEnums.mobilePayment:
        return Icons.mobile_friendly;
      case PaymentMethodEnums.cryptocurrency:
        return Icons.monetization_on;
      case PaymentMethodEnums.check:
        return Icons.check_circle;
      case PaymentMethodEnums.giftCard:
        return Icons.card_giftcard;
      case PaymentMethodEnums.invoice:
        return Icons.receipt;
      case PaymentMethodEnums.contactlessPayment:
        return Icons.nfc;
      case PaymentMethodEnums.digitalWallet:
        return Icons.wallet_giftcard;
      case PaymentMethodEnums.buyNowPayLater:
        return Icons.shopping_cart_checkout;
      case PaymentMethodEnums.prepaidCard:
        return Icons.card_membership;
      case PaymentMethodEnums.loyaltyPoints:
        return Icons.star_rate;
      case PaymentMethodEnums.bartering:
        return Icons.swap_horiz;
    }
  }

  Color get color {
    switch (this) {
      case PaymentMethodEnums.cash:
        return Colors.brown;
      case PaymentMethodEnums.creditCard:
        return Colors.blue;
      case PaymentMethodEnums.debitCard:
        return Colors.green;
      case PaymentMethodEnums.bankTransfer:
        return Colors.orange;
      case PaymentMethodEnums.mobilePayment:
        return Colors.purple;
      case PaymentMethodEnums.cryptocurrency:
        return Colors.yellow;
      case PaymentMethodEnums.check:
        return Colors.teal;
      case PaymentMethodEnums.giftCard:
        return Colors.red;
      case PaymentMethodEnums.invoice:
        return Colors.grey;
      case PaymentMethodEnums.contactlessPayment:
        return Colors.cyan;
      case PaymentMethodEnums.digitalWallet:
        return Colors.indigo;
      case PaymentMethodEnums.buyNowPayLater:
        return Colors.amber;
      case PaymentMethodEnums.prepaidCard:
        return Colors.lime;
      case PaymentMethodEnums.loyaltyPoints:
        return Colors.pink;
      case PaymentMethodEnums.bartering:
        return Colors.deepOrange;
    }
  }

  String get description {
    switch (this) {
      case PaymentMethodEnums.cash:
        return 'Physical currency used for transactions.';
      case PaymentMethodEnums.creditCard:
        return 'A card issued by a financial institution allowing the holder to borrow funds.';
      case PaymentMethodEnums.debitCard:
        return 'A card that deducts money directly from a consumer\'s checking account.';
      case PaymentMethodEnums.bankTransfer:
        return 'Electronic transfer of money from one bank account to another.';
      case PaymentMethodEnums.mobilePayment:
        return 'Payment made through a mobile device.';
      case PaymentMethodEnums.cryptocurrency:
        return 'Digital or virtual currency that uses cryptography for security.';
      case PaymentMethodEnums.check:
        return 'A written order directing a bank to pay money.';
      case PaymentMethodEnums.giftCard:
        return 'A prepaid card that can be used as a form of payment.';
      case PaymentMethodEnums.invoice:
        return 'A document requesting payment for goods or services.';
      case PaymentMethodEnums.contactlessPayment:
        return 'Payment made without physical contact between the card and the terminal.';
      case PaymentMethodEnums.digitalWallet:
        return 'An electronic device or online service that allows individuals to make electronic transactions.';
      case PaymentMethodEnums.buyNowPayLater:
        return 'A payment option allowing consumers to purchase items and pay for them later.';
      case PaymentMethodEnums.prepaidCard:
        return 'A card that is preloaded with funds and can be used until the balance is depleted.';
      case PaymentMethodEnums.loyaltyPoints:
        return 'Points earned through a loyalty program that can be redeemed for rewards.';
      case PaymentMethodEnums.bartering:
        return 'Exchange of goods or services without using money.';
    }
  }
}
