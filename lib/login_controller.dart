import 'package:flutter/material.dart';
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

      AppUtils.showLoading();
      await Future.delayed(const Duration(seconds: 3), () async {
        AppUtils.hideLoading();
        Get.toNamed(AppRoutes.main);
      });
    }
  }
}
