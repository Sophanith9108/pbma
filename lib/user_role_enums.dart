import 'package:hive/hive.dart';

part 'user_role_enums.g.dart';

@HiveType(typeId: 8)
enum UserRoleEnums {
  @HiveField(0)
  super_admin,

  @HiveField(1)
  admin,

  @HiveField(2)
  user,
}

extension UserRoleEnumsExtension on UserRoleEnums {
  String get value {
    switch (this) {
      case UserRoleEnums.super_admin:
        return "Super Admin";
      case UserRoleEnums.admin:
        return "Admin";
      case UserRoleEnums.user:
        return "User";
    }
  }
}
