import 'package:flutter/material.dart';

enum BankCardEnum {
  debit,
  credit,
  prepaid,
  charge,
  atm,
  virtual,
  business,
  securedCredit,
}

extension BankCardEnumExtension on BankCardEnum {
  String get name {
    switch (this) {
      case BankCardEnum.debit:
        return "Debit Card";
      case BankCardEnum.credit:
        return "Credit Card";
      case BankCardEnum.prepaid:
        return "Prepaid Card";
      case BankCardEnum.charge:
        return "Charge Card";
      case BankCardEnum.atm:
        return "ATM Card";
      case BankCardEnum.virtual:
        return "Virtual Card";
      case BankCardEnum.business:
        return "Business Card";
      case BankCardEnum.securedCredit:
        return "Secured Credit Card";
    }
  }

  String get description {
    switch (this) {
      case BankCardEnum.debit:
        return "Debit Card Description";
      case BankCardEnum.credit:
        return "Credit Card Description";
      case BankCardEnum.prepaid:
        return "Prepaid Card Description";
      case BankCardEnum.charge:
        return "Charge Card Description";
      case BankCardEnum.atm:
        return "ATM Card Description";
      case BankCardEnum.virtual:
        return "Virtual Card Description";
      case BankCardEnum.business:
        return "Business Card Description";
      case BankCardEnum.securedCredit:
        return "Secured Credit Card Description";
    }
  }

  IconData get icon {
    switch (this) {
      case BankCardEnum.debit:
        return Icons.credit_card;
      case BankCardEnum.credit:
        return Icons.credit_card;
      case BankCardEnum.prepaid:
        return Icons.card_giftcard;
      case BankCardEnum.charge:
        return Icons.account_balance_wallet;
      case BankCardEnum.atm:
        return Icons.atm;
      case BankCardEnum.virtual:
        return Icons.computer;
      case BankCardEnum.business:
        return Icons.business;
      case BankCardEnum.securedCredit:
        return Icons.lock;
    }
  }
}
