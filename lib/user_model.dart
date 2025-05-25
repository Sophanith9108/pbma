import 'package:equatable/equatable.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class UserModel extends Equatable {
  late String? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? password; // Store password as a hash
  late String? profilePicture;
  late String? address;
  late String? dateOfBirth;
  late GenderEnums? gender;
  late DateTime? createdAt;
  late DateTime? updatedAt;

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
    user.name = name;
    user.email = email;
    user.phone = phone;
    user.password = password?.hashPassword();
    user.profilePicture = profilePicture;
    user.address = address;
    user.dateOfBirth = dateOfBirth;
    user.gender = gender;
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
