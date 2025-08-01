import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class BankCardModel {
  final _id = Uuid().v8().obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _bankName = "".obs;
  String get bankName => _bankName.value;
  set bankName(String value) => _bankName.value = value;

  final _cardType = BankCardEnum.debit.obs;
  BankCardEnum get cardType => _cardType.value;
  set cardType(BankCardEnum value) => _cardType.value = value;

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

  final _status = BankCardStatusEnum.active.obs;
  BankCardStatusEnum get status => _status.value;
  set status(BankCardStatusEnum value) => _status.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  BankCardModel();

  factory BankCardModel.create({
    String? id,
    required String bankName,
    required BankCardEnum cardType,
    required PaymentNetworkEnum paymentNetwork,
    required double balance,
    required CurrencyEnums currency,
    required UserModel user,
    BankCardStatusEnum? status,
    DateTime? updatedAt,
  }) {
    return BankCardModel()
      ..id = id ?? Uuid().v8()
      ..bankName = bankName
      ..cardType = cardType
      ..paymentNetwork = paymentNetwork
      ..balance = balance
      ..currency = currency
      ..user = user
      ..status = status ?? BankCardStatusEnum.active
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static BankCardModel fromJson({required Map<dynamic, dynamic> json}) {
    return BankCardModel()
      ..id = json['id'] as String
      ..bankName = json['bankName'] as String
      ..cardType = BankCardEnum.values.firstWhere(
        (e) => e.name == json['cardType'],
        orElse: () => BankCardEnum.debit,
      )
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
      ..status = BankCardStatusEnum.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BankCardStatusEnum.active,
      )
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['createdAt'] as String),
      )
      ..updatedAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['updatedAt'] as String),
      );
  }

  static Map<String, dynamic> toJson({required BankCardModel model}) {
    return {
      'id': model.id,
      'bankName': model.bankName,
      'cardType': model.cardType.name,
      'paymentNetwork': model.paymentNetwork.name,
      'balance': model.balance,
      'currency': model.currency.name,
      'user': UserModel.toJson(model: model.user),
      'status': model.status.name,
      'createdAt': model.createdAt.millisecondsSinceEpoch.toString(),
      'updatedAt': model.updatedAt.millisecondsSinceEpoch.toString(),
    };
  }
}
