import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionRepository extends AppStorageRepository<TransactionModel> {
  final TransactionService _service = Get.put(TransactionService());

  @override
  Future<void> save(String key, TransactionModel value) async {
    return _service.create(TransactionModel.toEntity(value));
  }

  @override
  Future<TransactionModel?> get(String key) async {
    final TransactionEntity? entity = await _service.read(key);
    return entity != null ? TransactionEntity.toModel(entity) : null;
  }

  @override
  Future<List<TransactionModel>?> gets(String key) async {
    final List<TransactionEntity>? entities = await _service.reads();
    return entities?.map((e) => TransactionEntity.toModel(e)).toList();
  }

  @override
  Future<void> update(String key, TransactionModel value) async {
    return _service.update(TransactionModel.toEntity(value));
  }

  @override
  Future<void> delete(String key) async {
    return _service.delete(key);
  }
}
