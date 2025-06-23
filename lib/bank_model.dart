import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class BankModel {
  final _id = "".obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _name = "".obs;
  String get name => _name.value;
  set name(String value) => _name.value = value;

  final _type = "".obs;
  String get type => _type.value;
  set type(String value) => _type.value = value;

  final _licenseType = "".obs;
  String get licenseType => _licenseType.value;
  set licenseType(String value) => _licenseType.value = value;

  final _headquarters = "".obs;
  String get headquarters => _headquarters.value;
  set headquarters(String value) => _headquarters.value = value;

  final _website = "".obs;
  String get website => _website.value;
  set website(String value) => _website.value = value;

  final _phone = "".obs;
  String get phone => _phone.value;
  set phone(String value) => _phone.value = value;

  final _email = "".obs;
  String get email => _email.value;
  set email(String value) => _email.value = value;

  final _swiftBic = "".obs;
  String get swiftBic => _swiftBic.value;
  set swiftBic(String value) => _swiftBic.value = value;

  final _logo = "".obs;
  String get logo => _logo.value;
  set logo(String value) => _logo.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  BankModel();

  factory BankModel.create({
    String? id,
    required String name,
    required String type,
    required String licenseType,
    required String headquarters,
    required String website,
    required String phone,
    required String email,
    required String swiftBic,
    required String logo,
    DateTime? updatedAt,
  }) {
    return BankModel()
      ..id = id ?? Uuid().v8()
      ..name = name
      ..type = type
      ..licenseType = licenseType
      ..headquarters = headquarters
      ..website = website
      ..phone = phone
      ..email = email
      ..swiftBic = swiftBic
      ..logo = logo
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  BankModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    type = json['type'] ?? "";
    licenseType = json['licenseType'] ?? "";
    headquarters = json['headquarters'] ?? "";
    website = json['website'] ?? "";
    phone = json['phone'] ?? "";
    email = json['email'] ?? "";
    swiftBic = json['swiftBic'] ?? "";
    logo = json['logo'] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'licenseType': licenseType,
      'headquarters': headquarters,
      'website': website,
      'phone': phone,
      'email': email,
      'swiftBic': swiftBic,
      'logo': logo,
    };
  }
}
