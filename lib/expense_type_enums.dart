import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'expense_type_enums.g.dart';

@HiveType(typeId: 4)
enum ExpenseTypeEnums {
  @HiveField(0)
  food,

  @HiveField(1)
  transport,

  @HiveField(2)
  entertainment,

  @HiveField(3)
  shopping,

  @HiveField(4)
  health,

  @HiveField(5)
  education,

  @HiveField(6)
  travel,

  @HiveField(7)
  bills,

  @HiveField(8)
  other,
}

extension ExpenseTypeEnumsExtension on ExpenseTypeEnums {
  String get name {
    switch (this) {
      case ExpenseTypeEnums.food:
        return 'Food & Drink';
      case ExpenseTypeEnums.transport:
        return 'Transport';
      case ExpenseTypeEnums.entertainment:
        return 'Entertainment';
      case ExpenseTypeEnums.shopping:
        return 'Shopping';
      case ExpenseTypeEnums.health:
        return 'Health';
      case ExpenseTypeEnums.education:
        return 'Education';
      case ExpenseTypeEnums.travel:
        return 'Travel';
      case ExpenseTypeEnums.bills:
        return 'Bills';
      case ExpenseTypeEnums.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case ExpenseTypeEnums.food:
        return Icons.fastfood;
      case ExpenseTypeEnums.transport:
        return Icons.directions_car;
      case ExpenseTypeEnums.entertainment:
        return Icons.movie;
      case ExpenseTypeEnums.shopping:
        return Icons.shopping_cart;
      case ExpenseTypeEnums.health:
        return Icons.local_hospital;
      case ExpenseTypeEnums.education:
        return Icons.school;
      case ExpenseTypeEnums.travel:
        return Icons.airplanemode_active;
      case ExpenseTypeEnums.bills:
        return Icons.receipt;
      case ExpenseTypeEnums.other:
        return Icons.more_horiz;
    }
  }

  Color get color {
    switch (this) {
      case ExpenseTypeEnums.food:
        return Colors.red;
      case ExpenseTypeEnums.transport:
        return Colors.blue;
      case ExpenseTypeEnums.entertainment:
        return Colors.green;
      case ExpenseTypeEnums.shopping:
        return Colors.purple;
      case ExpenseTypeEnums.health:
        return Colors.orange;
      case ExpenseTypeEnums.education:
        return Colors.yellow;
      case ExpenseTypeEnums.travel:
        return Colors.teal;
      case ExpenseTypeEnums.bills:
        return Colors.brown;
      case ExpenseTypeEnums.other:
        return Colors.grey;
    }
  }

  String get description {
    switch (this) {
      case ExpenseTypeEnums.food:
        return 'Expenses related to food and dining.';
      case ExpenseTypeEnums.transport:
        return 'Expenses related to transportation.';
      case ExpenseTypeEnums.entertainment:
        return 'Expenses related to entertainment and leisure.';
      case ExpenseTypeEnums.shopping:
        return 'Expenses related to shopping and retail.';
      case ExpenseTypeEnums.health:
        return 'Expenses related to health and medical care.';
      case ExpenseTypeEnums.education:
        return 'Expenses related to education and learning.';
      case ExpenseTypeEnums.travel:
        return 'Expenses related to travel and vacations.';
      case ExpenseTypeEnums.bills:
        return 'Expenses related to bills and utilities.';
      case ExpenseTypeEnums.other:
        return 'Other miscellaneous expenses.';
    }
  }

  static ExpenseTypeEnums? fromString(String? name) {
    if (name == null) return null;
    return ExpenseTypeEnums.values.firstWhere((e) => e.name == name);
  }
}
