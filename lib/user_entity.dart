import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 1)
class UserEntity extends HiveObject {
  @HiveField(0)
  late String? id;

  @HiveField(1)
  late String? name;

  @HiveField(2)
  late String? email;

  @HiveField(3)
  late String? phone;

  @HiveField(4)
  late String? password; // Store password as a hash

  @HiveField(5)
  late String? profilePicture;

  @HiveField(6)
  late String? address;

  @HiveField(7)
  late String? dateOfBirth;

  @HiveField(8)
  late GenderEnums? gender;

  @HiveField(9)
  late DateTime? createdAt;

  @HiveField(10)
  late DateTime? updatedAt;

  @HiveField(11)
  late UserRoleEnums role;

  UserEntity();

  factory UserEntity.create({
    String? id,
    required String name,
    required String email,
    required String phone,
    required String password,
    String? profilePicture,
    required String address,
    String? dateOfBirth,
    GenderEnums? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserRoleEnums? role,
  }) {
    return UserEntity()
      ..id = Uuid().v8()
      ..name = name
      ..email = email
      ..phone = phone
      ..password = password
      ..profilePicture = profilePicture
      ..address = address
      ..dateOfBirth = dateOfBirth
      ..gender = gender
      ..createdAt = DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now()
      ..role = role ?? UserRoleEnums.user;
  }

  static UserModel toModel(UserEntity entity) {
    return UserModel()
      ..id = entity.id ?? ""
      ..name = entity.name ?? ""
      ..email = entity.email ?? ""
      ..phone = entity.phone ?? ""
      ..password = entity.password ?? ""
      ..profilePicture = entity.profilePicture ?? ''
      ..address = entity.address ?? ""
      ..dateOfBirth = entity.dateOfBirth ?? ''
      ..gender = entity.gender ?? GenderEnums.values.first
      ..createdAt = entity.createdAt ?? DateTime.now()
      ..updatedAt = entity.updatedAt ?? DateTime.now()
      ..role = entity.role;
  }
}
