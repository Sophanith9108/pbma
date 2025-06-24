import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreditCardFirebaseRepository
    extends AppFirebaseStorageRepository<CreditCardModel> {
  final CreditCardFirebaseService _service = Get.put(
    CreditCardFirebaseService(),
  );

  @override
  Future<CreditCardModel> create(CreditCardModel data) async {
    return await _service.create(data);
  }

  @override
  Future<void> delete(String id) async {
    return await _service.delete(id);
  }

  @override
  Future<CreditCardModel> read(String id) async {
    return await _service.read(id);
  }

  @override
  Future<List<CreditCardModel>> reads() async {
    return await _service.reads();
  }

  @override
  Future<CreditCardModel> update(CreditCardModel data) async {
    return await _service.update(data);
  }
}
