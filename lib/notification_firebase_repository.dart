import 'package:get/get.dart';
import 'package:pbma/core.dart';

class NotificationFirebaseRepository
    extends AppFirebaseStorageRepository<NotificationModel> {
  final NotificationFirebaseService _service = Get.put(
    NotificationFirebaseService(),
  );

  @override
  Future<NotificationModel> create(NotificationModel data) async {
    return _service.create(data);
  }

  @override
  Future<void> delete(String id) async {
    return _service.delete(id);
  }

  @override
  Future<NotificationModel> read(String id) async {
    return _service.read(id);
  }

  @override
  Future<List<NotificationModel>> reads() async {
    return _service.reads();
  }

  @override
  Future<NotificationModel> update(NotificationModel data) async {
    return _service.update(data);
  }
}
