import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum BankCardEnum { visa, mastercard, amex, discover, diners, jcb, unionPay }

extension BankCardEnumExtension on BankCardEnum {
  String get name {
    switch (this) {
      case BankCardEnum.visa:
        return 'Visa';
      case BankCardEnum.mastercard:
        return 'MasterCard';
      case BankCardEnum.amex:
        return 'American Express';
      case BankCardEnum.discover:
        return 'Discover';
      case BankCardEnum.diners:
        return 'Diners Club';
      case BankCardEnum.jcb:
        return 'JCB';
      case BankCardEnum.unionPay:
        return 'UnionPay';
    }
  }

  String get description {
    switch (this) {
      case BankCardEnum.visa:
        return 'Visa';
      case BankCardEnum.mastercard:
        return 'MasterCard';
      case BankCardEnum.amex:
        return 'American Express';
      case BankCardEnum.discover:
        return 'Discover';
      case BankCardEnum.diners:
        return 'Diners Club';
      case BankCardEnum.jcb:
        return 'JCB';
      case BankCardEnum.unionPay:
        return 'UnionPay';
    }
  }

  IconData get icon {
    switch (this) {
      case BankCardEnum.visa:
        return FontAwesomeIcons.ccVisa;
      case BankCardEnum.mastercard:
        return FontAwesomeIcons.ccMastercard;
      case BankCardEnum.amex:
        return FontAwesomeIcons.ccAmex;
      case BankCardEnum.discover:
        return FontAwesomeIcons.ccDiscover;
      case BankCardEnum.diners:
        return FontAwesomeIcons.ccDinersClub;
      case BankCardEnum.jcb:
        return FontAwesomeIcons.ccJcb;
      case BankCardEnum.unionPay:
        return FontAwesomeIcons
            .ccVisa; // Placeholder, UnionPay icon not available
    }
  }
}
