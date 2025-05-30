import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TargetRepository extends AppStorageRepository<TargetModel> {
  final TargetService _service = Get.put(TargetService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<TargetModel?> get(String key) async {
    var entity = await _service.read(key);
    return entity != null ? TargetEntity.toModel(entity: entity) : null;
  }

  @override
  Future<List<TargetModel>?> gets() async {
    var entities = await _service.reads();
    return entities?.map((e) => TargetEntity.toModel(entity: e)).toList() ?? [];
  }

  @override
  Future<void> save(TargetModel value) async {
    return _service.create(TargetModel.toEntity(model: value));
  }

  @override
  Future<void> update(TargetModel value) async {
    return _service.update(TargetModel.toEntity(model: value));
  }
}
