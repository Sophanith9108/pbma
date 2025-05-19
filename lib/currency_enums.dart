import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

enum CurrencyEnums { USD, KHR }

extension CurrencyEnumsExtension on CurrencyEnums {
  String get name {
    switch (this) {
      case CurrencyEnums.USD:
        return 'USD';
      case CurrencyEnums.KHR:
        return 'KHR';
    }
  }

  String get symbol {
    switch (this) {
      case CurrencyEnums.USD:
        return '\$';
      case CurrencyEnums.KHR:
        return '៛';
    }
  }

  String get code {
    switch (this) {
      case CurrencyEnums.USD:
        return 'USD';
      case CurrencyEnums.KHR:
        return 'KHR';
    }
  }

  IconData get icon {
    switch (this) {
      case CurrencyEnums.USD:
        return Symbols.paid;
      case CurrencyEnums.KHR:
        return Symbols.unpaved_road;
    }
  }

  String get description {
    switch (this) {
      case CurrencyEnums.USD:
        return 'United States Dollar';
      case CurrencyEnums.KHR:
        return 'Cambodian Riel';
    }
  }
}
