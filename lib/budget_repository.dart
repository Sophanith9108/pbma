import 'package:get/instance_manager.dart';
import 'package:pbma/core.dart';

class BudgetRepository extends AppStorageRepository<BudgetModel> {
  final BudgetService _service = Get.put(BudgetService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<BudgetModel?> get(String key) async {
    var entity = await _service.read(key);
    return entity != null ? BudgetEntity.toModel(entity: entity) : null;
  }

  @override
  Future<List<BudgetModel>?> gets() async {
    var entities = await _service.reads();
    return entities?.map((e) => BudgetEntity.toModel(entity: e)).toList() ?? [];
  }

  @override
  Future<void> save(BudgetModel value) async {
    return _service.create(BudgetModel.toEntity(model: value));
  }

  @override
  Future<void> update(BudgetModel value) async {
    return _service.update(BudgetModel.toEntity(model: value));
  }
}
