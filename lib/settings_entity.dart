import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

@HiveType(typeId: 12)
class SettingsEntity extends HiveObject {
  @HiveField(0)
  late String id;

  late LanguagesEnum language;

  late String theme;

  late bool enableNotification;

  late UserEntity createdBy;

  late DateTime createdAt;

  late DateTime updatedAt;
}
