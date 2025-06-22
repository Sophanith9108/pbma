import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class BankCardModel {
  final _id = Uuid().v8().obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _cardNumber = "".obs;
  String get cardNumber => _cardNumber.value;
  set cardNumber(String value) => _cardNumber.value = value;

  final _cardHolderName = "".obs;
  String get cardHolderName => _cardHolderName.value;
  set cardHolderName(String value) => _cardHolderName.value = value;

  final _expiryDate = "".obs;
  String get expiryDate => _expiryDate.value;
  set expiryDate(String value) => _expiryDate.value = value;

  final _cvv = "".obs;
  String get cvv => _cvv.value;
  set cvv(String value) => _cvv.value = value;

  final _bankName = "".obs;
  String get bankName => _bankName.value;
  set bankName(String value) => _bankName.value = value;

  final _cardType = "".obs;
  String get cardType => _cardType.value;
  set cardType(String value) => _cardType.value = value;

  final _cardBrand = "".obs;
  String get cardBrand => _cardBrand.value;
  set cardBrand(String value) => _cardBrand.value = value;

  final _cardImageUrl = "".obs;
  String get cardImageUrl => _cardImageUrl.value;
  set cardImageUrl(String value) => _cardImageUrl.value = value;

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  BankCardModel();

  factory BankCardModel.create({
    String? id,
    required String cardNumber,
    required String cardHolderName,
    required String expiryDate,
    required String cvv,
    required String bankName,
    required String cardType,
    required String cardBrand,
    String? cardImageUrl,
    required UserModel user,
    DateTime? updatedAt,
  }) {
    return BankCardModel()
      ..id = id ?? Uuid().v8()
      ..cardNumber = cardNumber
      ..cardHolderName = cardHolderName
      ..expiryDate = expiryDate
      ..cvv = cvv
      ..bankName = bankName
      ..cardType = cardType
      ..cardBrand = cardBrand
      ..cardImageUrl = cardImageUrl ?? ""
      ..user = user
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static BankCardModel fromJson({required Map<String, dynamic> json}) {
    return BankCardModel()
      ..id = json['id'] ?? Uuid().v8()
      ..cardNumber = json['cardNumber'] ?? ""
      ..cardHolderName = json['cardHolderName'] ?? ""
      ..expiryDate = json['expiryDate'] ?? ""
      ..cvv = json['cvv'] ?? ""
      ..bankName = json['bankName'] ?? ""
      ..cardType = json['cardType'] ?? ""
      ..cardBrand = json['cardBrand'] ?? ""
      ..cardImageUrl = json['cardImageUrl'] ?? ""
      ..user = UserModel.fromJson(json: json['user'])
      ..createdAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['createdAt']),
      )
      ..updatedAt = DateTime.fromMillisecondsSinceEpoch(
        int.parse(json['updatedAt']),
      );
  }

  static Map<String, dynamic> toJson({required BankCardModel model}) {
    return {
      'id': model.id,
      'cardNumber': model.cardNumber,
      'cardHolderName': model.cardHolderName,
      'expiryDate': model.expiryDate,
      'cvv': model.cvv,
      'bankName': model.bankName,
      'cardType': model.cardType,
      'cardBrand': model.cardBrand,
      'cardImageUrl': model.cardImageUrl,
      'user': model.user,
      'createdAt': model.createdAt.millisecondsSinceEpoch.toString(),
      'updatedAt': model.updatedAt.millisecondsSinceEpoch.toString(),
    };
  }
}
