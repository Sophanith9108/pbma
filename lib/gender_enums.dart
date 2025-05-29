import 'package:hive_flutter/hive_flutter.dart';

part 'gender_enums.g.dart';

@HiveType(typeId: 3)
enum GenderEnums {
  @HiveField(0)
  male,

  @HiveField(1)
  female,

  @HiveField(2)
  other,
}

extension GenderExtension on GenderEnums {
  String get value {
    switch (this) {
      case GenderEnums.male:
        return "Male";
      case GenderEnums.female:
        return "Female";
      case GenderEnums.other:
        return "Prefer not to say";
    }
  }
}
