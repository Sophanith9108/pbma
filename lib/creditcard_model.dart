import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreditCardModel {
  final _id = "".obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _paymentNetwork = PaymentNetworkEnum.visa.obs;
  PaymentNetworkEnum get paymentNetwork => _paymentNetwork.value;
  set paymentNetwork(PaymentNetworkEnum value) => _paymentNetwork.value = value;

  final _balance = 0.0.obs;
  double get balance => _balance.value;
  set balance(double value) => _balance.value = value;

  final _currency = CurrencyEnums.USD.obs;
  CurrencyEnums get currency => _currency.value;
  set currency(CurrencyEnums value) => _currency.value = value;

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  final _dueDate = DateTime.now().obs;
  DateTime get dueDate => _dueDate.value;
  set dueDate(DateTime value) => _dueDate.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  CreditCardModel();

  static CreditCardModel fromJson({required Map<dynamic, dynamic> json}) {
    return CreditCardModel()
      ..id = json['id'] as String
      ..paymentNetwork = PaymentNetworkEnum.values.firstWhere(
        (e) => e.name == json['paymentNetwork'],
        orElse: () => PaymentNetworkEnum.visa,
      )
      ..balance = (json['balance'] as num?)?.toDouble() ?? 0.0
      ..currency = CurrencyEnums.values.firstWhere(
        (e) => e.name == json['currency'],
        orElse: () => CurrencyEnums.USD,
      )
      ..user = UserModel.fromJson(json: json['user'] as Map<dynamic, dynamic>)
      ..dueDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['dueDate'] as String),
      )
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['createdAt'] as String),
      )
      ..updatedAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['updatedAt'] as String),
      );
  }

  static Map<String, dynamic> toJson({required CreditCardModel model}) {
    return {
      'id': model.id,
      'paymentNetwork': model.paymentNetwork.name,
      'balance': model.balance.toString(),
      'currency': model.currency.name,
      'user': UserModel.toJson(model: model.user),
      'dueDate': model.dueDate.millisecondsSinceEpoch.toString(),
      'createdAt': model.createdAt.millisecondsSinceEpoch.toString(),
      'updatedAt': model.updatedAt.millisecondsSinceEpoch.toString(),
    };
  }
}
