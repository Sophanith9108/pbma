import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class UserModel extends Equatable {
  final _id = ''.obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _name = ''.obs;
  String get name => _name.value;
  set name(String value) => _name.value = value;

  final _email = ''.obs;
  String get email => _email.value;
  set email(String value) => _email.value = value;

  final _phone = ''.obs;
  String get phone => _phone.value;
  set phone(String value) => _phone.value = value;

  final _password = ''.obs; // Store password as a hash
  String get password => _password.value;
  set password(String value) => _password.value = value;

  final _profilePicture = ''.obs;
  String get profilePicture => _profilePicture.value;
  set profilePicture(String value) => _profilePicture.value = value;

  final _address = ''.obs;
  String get address => _address.value;
  set address(String value) => _address.value = value;

  final _dateOfBirth = ''.obs;
  String get dateOfBirth => _dateOfBirth.value;
  set dateOfBirth(String value) => _dateOfBirth.value = value;

  final _gender = GenderEnums.values.first.obs;
  GenderEnums get gender => _gender.value;
  set gender(GenderEnums value) => _gender.value = value;

  final _role = UserRoleEnums.user.obs;
  UserRoleEnums get role => _role.value;
  set role(UserRoleEnums value) => _role.value = value;

  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;
  set isLogin(bool value) => _isLogin.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  UserModel();

  factory UserModel.create({
    String? id,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String address,
    String? profilePicture,
    String? dateOfBirth,
    GenderEnums? gender,
    DateTime? updatedAt,
    UserRoleEnums? role,
    bool? isLogin,
  }) {
    return UserModel()
      ..id = id ?? Uuid().v8()
      ..name = name
      ..email = email
      ..phone = phone
      ..password = password.hashPassword()
      ..profilePicture = profilePicture ?? ""
      ..address = address
      ..dateOfBirth = dateOfBirth ?? ""
      ..gender = gender ?? GenderEnums.other
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now()
      ..role = role ?? UserRoleEnums.user
      ..isLogin = isLogin ?? false;
  }

  static Map<String, dynamic> toJson({required UserModel model}) {
    return {
      "id": model.id.toString(),
      "name": model.name.toString(),
      "email": model.email.toString(),
      "phone": model.phone.toString(),
      "password": model.password.toString(),
      "profilePicture": model.profilePicture.toString(),
      "address": model.address.toString(),
      "dateOfBirth": model.dateOfBirth.toString(),
      "gender": model.gender.name.toString(),
      "createdAt": model.createdAt.millisecondsSinceEpoch.toString(),
      "updatedAt": model.updatedAt.millisecondsSinceEpoch.toString(),
      "role": model.role.name.toString(),
      "isLogin": model.isLogin.toString(),
    };
  }

  static UserModel fromJson({required Map<dynamic, dynamic> json}) {
    return UserModel()
      ..id = json['id']
      ..name = json['name']
      ..email = json['email']
      ..phone = json['phone']
      ..password = json['password']
      ..profilePicture = json['profilePicture']
      ..address = json['address']
      ..dateOfBirth = json['dateOfBirth']
      ..gender = GenderEnums.values.byName(json['gender'])
      ..createdAt = DateTime.tryParse(json['createdAt']) ?? DateTime.now()
      ..updatedAt = DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
      ..role = UserRoleEnums.values.byName(json['role'])
      ..isLogin = json['isLogin'] == 'true';
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity()
      ..id = model.id
      ..name = model.name
      ..email = model.email
      ..phone = model.phone
      ..password = model.password.hashPassword()
      ..profilePicture = model.profilePicture
      ..address = model.address
      ..dateOfBirth = model.dateOfBirth
      ..gender = model.gender
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt
      ..role = model.role
      ..isLogin = model.isLogin;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    password,
    profilePicture,
    address,
    dateOfBirth,
    gender,
    createdAt,
    updatedAt,
    role,
    isLogin,
  ];
}
