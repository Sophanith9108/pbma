import 'package:hive/hive.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

part 'settings_entity.g.dart';

@HiveType(typeId: 12)
class SettingsEntity extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late LanguagesEnum language;

  @HiveField(2)
  late String theme;

  @HiveField(3)
  late bool enableNotification;

  @HiveField(4)
  late UserEntity createdBy;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  late DateTime updatedAt;

  SettingsEntity();

  factory SettingsEntity.create({
    String? id,
    required LanguagesEnum language,
    required String theme,
    required bool enableNotification,
    required UserEntity createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SettingsEntity()
      ..id = id ?? const Uuid().v8()
      ..language = language
      ..theme = theme
      ..enableNotification = enableNotification
      ..createdBy = createdBy
      ..createdAt = createdAt ?? DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
  }

  static SettingsModel toModel(SettingsEntity entity) {
    return SettingsModel()
      ..id = entity.id
      ..language = entity.language
      ..theme = entity.theme
      ..enableNotification = entity.enableNotification
      ..createdBy = UserEntity.toModel(entity.createdBy)
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt;
  }

  static SettingsEntity toEntity(SettingsModel model) {
    return SettingsEntity()
      ..id = model.id
      ..language = model.language
      ..theme = model.theme
      ..enableNotification = model.enableNotification
      ..createdBy = UserEntity.toEntity(model.createdBy)
      ..createdAt = model.createdAt
      ..updatedAt = model.updatedAt;
  }
}
