import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
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

  final _showBiometric = false.obs;
  bool get showBiometric => _showBiometric.value;
  set showBiometric(bool value) => _showBiometric.value = value;

  @override
  void onInit() {
    checkIfBiometricAvialable();
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

  Future<void> onLogin() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();

      var users = await userRepository.gets() ?? [];
      if (users.isEmpty) {
        AppUtils.showWarning("User is not yet register!".tr);
        return;
      }

      String phone = phoneController.text.trim();
      if (users.firstWhereOrNull((user) => user.phone == phone) == null) {
        AppUtils.showError('User not found with this phone number'.tr);
        return;
      }

      String password = passwordController.text.trim();
      if (users.firstWhereOrNull((user) => user.password == password) == null) {
        AppUtils.showError('Wrong password'.tr);
        return;
      }

      AppUtils.showLoading();

      var currentUser = users.first;
      var user = UserModel.create(
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        name: currentUser.name.trim(),
        email: currentUser.email.trim(),
        address: currentUser.address.trim(),
        gender: currentUser.gender,
        profilePicture: currentUser.profilePicture,
        role: currentUser.role,
        dateOfBirth: currentUser.dateOfBirth,
        updatedAt: DateTime.now(),
        isLogin: true,
      );

      userRepository.update(user).then((response) async {
        AppUtils.hideLoading();

        await _onClear();
        Get.offAllNamed(AppRoutes.main);
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

  Future<void> gotoForgotPassword() async {
    await Future.delayed(Duration(milliseconds: 300));
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () {
      AppUtils.hideLoading();
    });
  }

  Future<void> loginWithBiometrics() async {
    await Future.delayed(Duration(milliseconds: 300));

    var users = await userRepository.gets() ?? [];
    if (users.isEmpty) {
      AppUtils.showWarning("User is not yet register!".tr);
      return;
    }

    if (!showBiometric) {
      AppUtils.showWarning('Biometric authentication is not available'.tr);
      return;
    }

    await biometricAuth();
  }

  Future<void> checkIfBiometricAvialable() async {
    var availableBiometrics =
        await LocalAuthentication().getAvailableBiometrics();
    var isAvailable = await LocalAuthentication().canCheckBiometrics;

    showBiometric = isAvailable && availableBiometrics.isNotEmpty;
  }

  void gotoRegister() async {
    await Future.delayed(Duration(milliseconds: 300));
    Get.offAllNamed(AppRoutes.register);
  }
}
