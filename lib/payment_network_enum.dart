import 'package:flutter/material.dart';

enum PaymentNetworkEnum {
  visa,
  mastercard,
  amex,
  discover,
  unionPay,
  jcb,
  rupay,
  dinersClub,
}

extension PaymentNetworkEnumExtension on PaymentNetworkEnum {
  String get name {
    switch (this) {
      case PaymentNetworkEnum.visa:
        return 'Visa';
      case PaymentNetworkEnum.mastercard:
        return 'MasterCard';
      case PaymentNetworkEnum.amex:
        return 'American Express';
      case PaymentNetworkEnum.discover:
        return 'Discover';
      case PaymentNetworkEnum.unionPay:
        return 'UnionPay';
      case PaymentNetworkEnum.jcb:
        return 'JCB';
      case PaymentNetworkEnum.rupay:
        return 'RuPay';
      case PaymentNetworkEnum.dinersClub:
        return 'Diners Club';
    }
  }

  String get description {
    switch (this) {
      case PaymentNetworkEnum.visa:
        return 'Visa';
      case PaymentNetworkEnum.mastercard:
        return 'MasterCard';
      case PaymentNetworkEnum.amex:
        return 'American Express';
      case PaymentNetworkEnum.discover:
        return 'Discover';
      case PaymentNetworkEnum.unionPay:
        return 'UnionPay';
      case PaymentNetworkEnum.jcb:
        return 'JCB';
      case PaymentNetworkEnum.rupay:
        return 'RuPay';
      case PaymentNetworkEnum.dinersClub:
        return 'Diners Club';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentNetworkEnum.visa:
        return Icons.credit_card;
      case PaymentNetworkEnum.mastercard:
        return Icons.credit_card;
      case PaymentNetworkEnum.amex:
        return Icons.credit_card;
      case PaymentNetworkEnum.discover:
        return Icons.credit_card;
      case PaymentNetworkEnum.unionPay:
        return Icons.credit_card;
      case PaymentNetworkEnum.jcb:
        return Icons.credit_card;
      case PaymentNetworkEnum.rupay:
        return Icons.credit_card;
      case PaymentNetworkEnum.dinersClub:
        return Icons.credit_card;
    }
  }

  String get code {
    switch (this) {
      case PaymentNetworkEnum.visa:
        return 'V';
      case PaymentNetworkEnum.mastercard:
        return 'MC';
      case PaymentNetworkEnum.amex:
        return 'AMEX';
      case PaymentNetworkEnum.discover:
        return 'DISC';
      case PaymentNetworkEnum.unionPay:
        return 'UPI';
      case PaymentNetworkEnum.jcb:
        return 'JCB';
      case PaymentNetworkEnum.rupay:
        return 'RUPAY';
      case PaymentNetworkEnum.dinersClub:
        return 'DC';
    }
  }
}
