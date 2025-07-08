import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentNetworkEnum { visa, mastercard, amex, discover, jcb, dinersClub }

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
      case PaymentNetworkEnum.jcb:
        return 'JCB';
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
      case PaymentNetworkEnum.jcb:
        return 'JCB';
      case PaymentNetworkEnum.dinersClub:
        return 'Diners Club';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentNetworkEnum.visa:
        return FontAwesomeIcons.ccVisa;
      case PaymentNetworkEnum.mastercard:
        return FontAwesomeIcons.ccMastercard;
      case PaymentNetworkEnum.amex:
        return FontAwesomeIcons.ccAmex;
      case PaymentNetworkEnum.discover:
        return FontAwesomeIcons.ccDiscover;
      case PaymentNetworkEnum.jcb:
        return FontAwesomeIcons.ccJcb;
      case PaymentNetworkEnum.dinersClub:
        return FontAwesomeIcons.ccDinersClub;
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
      case PaymentNetworkEnum.jcb:
        return 'JCB';
      case PaymentNetworkEnum.dinersClub:
        return 'DC';
    }
  }
}
