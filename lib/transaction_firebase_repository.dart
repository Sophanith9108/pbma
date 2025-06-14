import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionFirebaseRepository
    extends AppRemoteRepository<TransactionModel> {
  final TransactionFirebaseService _firebaseService = Get.put(
    TransactionFirebaseService(),
  );

  @override
  Future<void> add(TransactionModel value) async {
    return _firebaseService.create(value);
  }

  @override
  Future<void> delete(String key) async {
    return _firebaseService.delete(key);
  }

  @override
  Future<TransactionModel> get(String key) async {
    return _firebaseService.read(key);
  }

  @override
  Future<List<TransactionModel>?> gets() async {
    return _firebaseService.reads();
  }

  @override
  Future<void> update(TransactionModel value) async {
    return _firebaseService.update(value);
  }
}
