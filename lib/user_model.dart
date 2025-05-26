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

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  UserModel();
  factory UserModel.create({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? profilePicture,
    String? address,
    String? dateOfBirth,
    GenderEnums? gender,
    DateTime? updatedAt,
  }) {
    var user = UserModel();
    user.id = Uuid().v4();
    user.name = name ?? "";
    user.email = email ?? "";
    user.phone = phone ?? "";
    user.password = password?.hashPassword() ?? "";
    user.profilePicture = profilePicture ?? "";
    user.address = address ?? "";
    user.dateOfBirth = dateOfBirth ?? "";
    user.gender = gender ?? GenderEnums.values.first;
    user.createdAt = DateTime.now();
    user.updatedAt = updatedAt ?? DateTime.now();
    return user;
  }

  static UserEntity toEntity(UserModel model) {
    return UserEntity()
      ..id = model.id
      ..name = model.name
      ..email = model.email
      ..phone = model.phone
      ..password = model.password!.hashPassword()
      ..profilePicture = model.profilePicture
      ..address = model.address
      ..dateOfBirth = model.dateOfBirth
      ..gender = model.gender
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt;
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
  ];
}
