import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

part 'languages_enum.g.dart';

@HiveType(typeId: 13)
enum LanguagesEnum {
  @HiveField(0)
  English,

  @HiveField(1)
  Khmer,

  @HiveField(2)
  Japanese,

  @HiveField(3)
  Chinese,
}

extension LanguagesEnumExtension on LanguagesEnum {
  String get name {
    switch (this) {
      case LanguagesEnum.English:
        return "English";
      case LanguagesEnum.Khmer:
        return "Khmer";
      case LanguagesEnum.Japanese:
        return "Japanese";
      case LanguagesEnum.Chinese:
        return "Chinese";
    }
  }
}

extension LanguagesEnumExtensionIcon on LanguagesEnum {
  IconData get icon {
    switch (this) {
      case LanguagesEnum.English:
        return FontAwesomeIcons.earthAmericas;
      case LanguagesEnum.Khmer:
        return FontAwesomeIcons.earthAsia;
      case LanguagesEnum.Japanese:
        return FontAwesomeIcons.earthAsia;
      case LanguagesEnum.Chinese:
        return FontAwesomeIcons.earthAsia;
    }
  }
}

extension LanguagesEnumExtensionLocale on LanguagesEnum {
  Locale get locale {
    switch (this) {
      case LanguagesEnum.English:
        return Locale("en_US");
      case LanguagesEnum.Khmer:
        return Locale("km_KH");
      case LanguagesEnum.Japanese:
        return Locale("ja_JP");
      case LanguagesEnum.Chinese:
        return Locale("zh_CN");
    }
  }
}
