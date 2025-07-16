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

  final _deviceId = ''.obs;
  String get deviceId => _deviceId.value;
  set deviceId(String value) => _deviceId.value = value;

  final _deviceToken = ''.obs;
  String get deviceToken => _deviceToken.value;
  set deviceToken(String value) => _deviceToken.value = value;

  final _deviceInfo = "".obs;
  String get deviceInfo => _deviceInfo.value;
  set deviceInfo(String value) => _deviceInfo.value = value;

  final _enableBiometric = false.obs;
  bool get enableBiometric => _enableBiometric.value;
  set enableBiometric(bool value) => _enableBiometric.value = value;

  final _status = UserStatusEnums.active.obs;
  UserStatusEnums get status => _status.value;
  set status(UserStatusEnums value) => _status.value = value;

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
    required String deviceId,
    required String deviceToken,
    required String deviceInfo,
    String? profilePicture,
    String? dateOfBirth,
    GenderEnums? gender,
    DateTime? updatedAt,
    UserRoleEnums? role,
    bool? isLogin,
    bool? enableBiometric,
    UserStatusEnums? status,
  }) {
    return UserModel()
      ..id = id ?? Uuid().v8()
      ..name = name
      ..email = email
      ..phone = phone
      ..password = password
      ..profilePicture = profilePicture ?? ""
      ..address = address
      ..dateOfBirth = dateOfBirth ?? ""
      ..gender = gender ?? GenderEnums.other
      ..deviceId = deviceId
      ..deviceToken = deviceToken
      ..deviceInfo = deviceInfo
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now()
      ..role = role ?? UserRoleEnums.user
      ..isLogin = isLogin ?? false
      ..enableBiometric = enableBiometric ?? false
      ..status = status ?? UserStatusEnums.active;
  }

  static Map<String, dynamic> toJson({required UserModel model}) {
    return {
      "id": model.id,
      "name": model.name,
      "email": model.email,
      "phone": model.phone,
      "password": model.password,
      "profilePicture": model.profilePicture,
      "address": model.address,
      "dateOfBirth": model.dateOfBirth,
      "gender": model.gender.name,
      "createdAt": model.createdAt.millisecondsSinceEpoch.toString(),
      "updatedAt": model.updatedAt.millisecondsSinceEpoch.toString(),
      "role": model.role.name,
      "isLogin": model.isLogin.toString(),
      "deviceId": model.deviceId,
      "deviceToken": model.deviceToken,
      "deviceInfo": model.deviceInfo,
      "enableBiometric": model.enableBiometric.toString(),
      "status": model.status.name,
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
      ..deviceId = json['deviceId']
      ..deviceToken = json['deviceToken']
      ..deviceInfo = json['deviceInfo']
      ..isLogin = json['isLogin'] == 'true'
      ..enableBiometric = json['enableBiometric'] == 'true'
      ..status = UserStatusEnums.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => UserStatusEnums.active,
      );
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity()
      ..id = model.id
      ..name = model.name
      ..email = model.email
      ..phone = model.phone
      ..password = model.password
      ..profilePicture = model.profilePicture
      ..address = model.address
      ..dateOfBirth = model.dateOfBirth
      ..gender = model.gender
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt
      ..role = model.role
      ..isLogin = model.isLogin
      ..deviceId = model.deviceId
      ..deviceToken = model.deviceToken
      ..deviceInfo = model.deviceInfo
      ..enableBiometric = model.enableBiometric
      ..status = model.status;
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
    deviceId,
    deviceToken,
    deviceInfo,
    enableBiometric,
    status,
  ];

  UserModel copyWith({required bool enableBiometric}) {
    return UserModel()
      ..id = id
      ..name = name
      ..email = email
      ..phone = phone
      ..password = password
      ..profilePicture = profilePicture
      ..address = address
      ..dateOfBirth = dateOfBirth
      ..gender = gender
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..role = role
      ..isLogin = isLogin
      ..deviceId = deviceId
      ..deviceToken = deviceToken
      ..deviceInfo = deviceInfo
      ..enableBiometric = enableBiometric
      ..deviceId = deviceId
      ..deviceToken = deviceToken
      ..deviceInfo = deviceInfo
      ..status = status;
  }
}
