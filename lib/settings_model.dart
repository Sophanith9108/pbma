import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:uuid/uuid.dart';

class SettingsModel extends Equatable {
  final _id = "".obs;
  String get id => _id.value;
  set id(String value) => _id.value = value;

  final _language = LanguagesEnum.English.obs;
  LanguagesEnum get language => _language.value;
  set language(LanguagesEnum value) => _language.value = value;

  final _theme = "".obs;
  String get theme => _theme.value;
  set theme(String value) => _theme.value = value;

  final _enableNotification = false.obs;
  bool get enableNotification => _enableNotification.value;
  set enableNotification(bool value) => _enableNotification.value = value;

  final _createdBy = UserModel().obs;
  UserModel get createdBy => _createdBy.value;
  set createdBy(UserModel value) => _createdBy.value = value;

  final _createdAt = DateTime.now().obs;
  DateTime get createdAt => _createdAt.value;
  set createdAt(DateTime value) => _createdAt.value = value;

  final _updatedAt = DateTime.now().obs;
  DateTime get updatedAt => _updatedAt.value;
  set updatedAt(DateTime value) => _updatedAt.value = value;

  SettingsModel();

  factory SettingsModel.create({
    String? id,
    LanguagesEnum? language,
    String? theme,
    bool? enableNotification,
    required UserModel createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SettingsModel()
      ..id = id ?? const Uuid().v8()
      ..language = language ?? LanguagesEnum.English
      ..theme = theme ?? ThemeMode.system.name
      ..enableNotification = enableNotification ?? false
      ..createdBy = createdBy
      ..createdAt = createdAt ?? DateTime.now()
      ..updatedAt = updatedAt ?? DateTime.now();
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

  @override
  List<Object?> get props => [
    id,
    language,
    theme,
    enableNotification,
    createdBy,
    createdAt,
    updatedAt,
  ];
}
