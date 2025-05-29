import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class LoginController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _phoneController = TextEditingController().obs;
  TextEditingController get phoneController => _phoneController.value;
  set phoneController(TextEditingController value) =>
      _phoneController.value = value;

  final _passwordController = TextEditingController().obs;
  TextEditingController get passwordController => _passwordController.value;
  set passwordController(TextEditingController value) =>
      _passwordController.value = value;

  Future<void> onLogin() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();

      var users = await userRepository.gets() ?? [];
      if (users.isEmpty) {
        Fluttertoast.showToast(msg: 'Please register first'.tr);
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.register);
        return;
      }

      AppUtils.showLoading();
      await Future.delayed(const Duration(seconds: 3), () async {
        AppUtils.hideLoading();

        List<UserModel> users = await userRepository.gets() ?? [];
        String phone = phoneController.text.trim();
        if (users.firstWhereOrNull((user) => user.phone == phone) == null) {
          AppUtils.showError('User not found with this phone number'.tr);
          return;
        }

        var user = UserModel.create(
          phone: phoneController.text,
          password: passwordController.text,
          updatedAt: DateTime.now(),
          name: users.first.name,
          email: users.first.email,
          address: users.first.email,
        );
        userRepository.update(user).then((response) async {
          await _onClear();
          Get.offAllNamed(AppRoutes.main);
        });
      }).catchError((error) {
        AppUtils.showError(error.toString());
      });
    }
  }

  Future<void> _onClear() async {
    phoneController.clear();
    passwordController.clear();
    formKey.currentState!.reset();

    phoneController.text = "";
    passwordController.text = "";
  }
}
