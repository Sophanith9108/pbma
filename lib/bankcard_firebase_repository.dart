import 'package:get/get.dart';
import 'package:pbma/core.dart';

class BankCardFirebaseRepository
    extends AppFirebaseStorageRepository<BankCardModel> {
  final BankCardFirebaseService _service = Get.put(BankCardFirebaseService());

  @override
  Future<BankCardModel> create(BankCardModel data) async {
    return await _service.create(data);
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id);
  }

  @override
  Future<BankCardModel> read(String id) async {
    return await _service.read(id);
  }

  @override
  Future<List<BankCardModel>> reads() async {
    return await _service.reads();
  }

  @override
  Future<BankCardModel> update(BankCardModel data) async {
    return await _service.update(data);
  }
}
