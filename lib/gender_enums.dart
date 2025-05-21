enum GenderEnums { male, female }

extension GenderExtension on GenderEnums {
  String get value {
    switch (this) {
      case GenderEnums.male:
        return "Male";
      case GenderEnums.female:
        return "Female";
    }
  }
}
