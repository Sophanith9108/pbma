import 'package:get/get.dart';
import 'package:pbma/core.dart';

class BudgetFirebaseRepository extends AppRemoteRepository<BudgetModel> {
  final BudgetFirebaseService _service = Get.put(BudgetFirebaseService());

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }

  @override
  Future<BudgetModel> get(String key) async {
    return _service.read(key);
  }

  @override
  Future<List<BudgetModel>?> gets() async {
    return _service.reads();
  }

  @override
  Future<void> save(BudgetModel value) async {
    return _service.add(value);
  }

  @override
  Future<void> update(BudgetModel value) async {
    return _service.update(value);
  }
}
