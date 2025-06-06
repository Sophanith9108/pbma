import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class BudgetModel extends Equatable {
  final _id = Uuid().v8().obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _name = "".obs;
  String get name => _name.value;
  set name(String value) => _name.value = value;

  final _amount = 0.0.obs;
  double get amount => _amount.value;
  set amount(double value) => _amount.value = value;

  final _currency = CurrencyEnums.USD.obs;
  CurrencyEnums get currency => _currency.value;
  set currency(CurrencyEnums value) => _currency.value = value;

  final _purpose = "".obs;
  String get purpose => _purpose.value;
  set purpose(String value) => _purpose.value = value;

  final _date = DateTime.now().obs;
  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  BudgetModel();

  factory BudgetModel.create({
    String? id,
    required String name,
    required double amount,
    required CurrencyEnums currency,
    required String purpose,
    required DateTime date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BudgetModel()
      ..id = id ?? Uuid().v8()
      ..name = name
      ..amount = amount
      ..currency = currency
      ..purpose = purpose
      ..date = date
      ..createdAt = createdAt ?? DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static BudgetEntity toEntity({required BudgetModel model}) {
    return BudgetEntity()
      ..id = model.id
      ..name = model.name
      ..amount = model.amount
      ..currency = model.currency
      ..purpose = model.purpose
      ..date = model.date
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt;
  }

  static List<BudgetModel> mockup() {
    return [
      BudgetModel.create(
        name: 'Food',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Food',
        date: DateTime.now(),
      ),
      BudgetModel.create(
        name: 'Entertainment',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Entertainment',
        date: DateTime.now(),
      ),
      BudgetModel.create(
        name: 'Travel',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Travel',
        date: DateTime.now(),
      ),
      BudgetModel.create(
        name: 'Shopping',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Shopping',
        date: DateTime.now(),
      ),
      BudgetModel.create(
        name: 'Health',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Health',
        date: DateTime.now(),
      ),
      BudgetModel.create(
        name: 'Education',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Education',
        date: DateTime.now(),
      ),
      BudgetModel.create(
        name: 'Bills',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Bills',
        date: DateTime.now(),
      ),
    ];
  }

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    currency,
    purpose,
    date,
    createdAt,
    updatedAt,
  ];
}
