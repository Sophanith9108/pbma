import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileController extends MainController {
  final _user = UserModel.create().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setData() async {
    var user = await userRepository.gets();
    if (user != null && user.isNotEmpty) {
      this.user = user.first;
    } else {
      this.user = UserModel.create();
    }
  }
}
