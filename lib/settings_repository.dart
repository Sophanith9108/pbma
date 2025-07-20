import 'package:get/get.dart';
import 'package:pbma/core.dart';

class SettingsRepository extends AppStorageRepository<SettingsModel> {
  final SettingsService _service = Get.put(SettingsService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<SettingsModel?> get(String key) async {
    return _service
        .read(key)
        .then((value) => value != null ? SettingsModel.toModel(value) : null);
  }

  @override
  Future<List<SettingsModel>?> gets() async {
    return _service.reads().then(
      (value) => value?.map((e) => SettingsModel.toModel(e)).toList(),
    );
  }

  @override
  Future<void> save(SettingsModel value) async {
    return _service.create(SettingsEntity.toEntity(value));
  }

  @override
  Future<void> update(SettingsModel value) async {
    return _service.update(SettingsEntity.toEntity(value));
  }
}
