import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pbma/core.dart';

class SettingsService extends AppStorageService<SettingsEntity> {
  Box<SettingsEntity> get settingsBox {
    final boxName =
        kDebugMode
            ? 'debug_${AppStorageBox.settingsBox}'
            : kProfileMode
            ? 'profile_${AppStorageBox.settingsBox}'
            : AppStorageBox.settingsBox;
    return Hive.box<SettingsEntity>(boxName);
  }

  @override
  Future<void> create(SettingsEntity value) async {
    return settingsBox.put(value.id, value);
  }

  @override
  Future<void> delete(String key) async {
    return settingsBox.delete(key);
  }

  @override
  Future<SettingsEntity?> read(String key) async {
    return settingsBox.get(key);
  }

  @override
  Future<List<SettingsEntity>?> reads() async {
    return settingsBox.values.toList();
  }

  @override
  Future<void> update(SettingsEntity value) async {
    return settingsBox.put(value.id, value);
  }
}
