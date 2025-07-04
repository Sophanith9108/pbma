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
      ..id = json['id'] as String
      ..name = json['name'] as String
      ..amount = double.tryParse(json['amount'])?.toDouble() ?? 0.0
      ..currency = CurrencyEnums.values.firstWhere(
        (e) => e.name == json['currency'],
        orElse: () => CurrencyEnums.USD,
      )
      ..purpose = json['purpose'] as String
      ..createdBy = UserModel.fromJson(
        json: json['createdBy'] as Map<dynamic, dynamic>,
      )
      ..updatedBy = UserModel.fromJson(
        json: json['updatedBy'] as Map<dynamic, dynamic>,
      )
      ..date = DateTime.parse(json['date'] as String)
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = DateTime.parse(json['updatedAt'] as String);
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
