import 'package:hive/hive.dart';

part 'userstatus_enum.g.dart';

@HiveType(typeId: 11)
enum UserStatusEnums {
  @HiveField(0)
  active,

  @HiveField(1)
  inactive,

  @HiveField(2)
  pending,

  @HiveField(3)
  blocked,

  @HiveField(4)
  deleted,
}

extension UserStatusEnumsExtension on UserStatusEnums {
  String get name {
    switch (this) {
      case UserStatusEnums.active:
        return "Active";
      case UserStatusEnums.inactive:
        return "Inactive";
      case UserStatusEnums.pending:
        return "Pending";
      case UserStatusEnums.blocked:
        return "Blocked";
      case UserStatusEnums.deleted:
        return "Deleted";
    }
  }
}
