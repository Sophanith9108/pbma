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

  final _createdBy = UserModel().obs;
  UserModel get createdBy => _createdBy.value;
  set createdBy(UserModel value) => _createdBy.value = value;

  final _updatedBy = UserModel().obs;
  UserModel get updatedBy => _updatedBy.value;
  set updatedBy(UserModel value) => _updatedBy.value = value;

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
    required UserModel createdBy,
    required UserModel updatedBy,
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
      ..createdBy = createdBy
      ..updatedBy = updatedBy
      ..date = date
      ..createdAt = createdAt ?? DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static Map<String, dynamic> toJson({required BudgetModel model}) {
    return {
      "id": model.id.toString(),
      "name": model.name.toString(),
      "amount": model.amount.toString(),
      "currency": model.currency.name.toString(),
      "purpose": model.purpose.toString(),
      "createdBy": UserModel.toJson(model: model.createdBy),
      "updatedBy": UserModel.toJson(model: model.updatedBy),
      "date": model.date.toString(),
      "createdAt": model.createdAt.toString(),
      "updatedAt": model.updatedAt.toString(),
    };
  }

  static BudgetModel fromJson({required Map<dynamic, dynamic> json}) {
    return BudgetModel()
      ..id = json["id"].toString()
      ..name = json["name"].toString()
      ..amount = double.parse(json["amount"].toString())
      ..currency = CurrencyEnums.values.firstWhere(
        (element) => element.name == json["currency"].toString(),
      )
      ..purpose = json["purpose"].toString()
      ..createdBy = UserModel.fromJson(json: json["createdBy"])
      ..updatedBy = UserModel.fromJson(json: json["updatedBy"])
      ..date = DateTime.parse(json["date"].toString())
      ..createdAt = DateTime.parse(json["createdAt"].toString())
      ..updatedAt = DateTime.parse(json["updatedAt"].toString());
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
    var user = UserModel.mockup().first;

    return [
      BudgetModel.create(
        name: 'Food',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Food',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
      ),
      BudgetModel.create(
        name: 'Entertainment',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Entertainment',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
      ),
      BudgetModel.create(
        name: 'Travel',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Travel',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
      ),
      BudgetModel.create(
        name: 'Shopping',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Shopping',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
      ),
      BudgetModel.create(
        name: 'Health',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Health',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
      ),
      BudgetModel.create(
        name: 'Education',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Education',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
      ),
      BudgetModel.create(
        name: 'Bills',
        amount: 1000,
        currency: CurrencyEnums.USD,
        purpose: 'Bills',
        date: DateTime.now(),
        createdBy: user,
        updatedBy: user,
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
    createdBy,
    updatedBy,
    date,
    createdAt,
    updatedAt,
  ];
}
