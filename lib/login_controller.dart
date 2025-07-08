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

  final _showPassword = false.obs;
  bool get showPassword => _showPassword.value;
  set showPassword(bool value) => _showPassword.value = value;

  @override
  void onInit() async {
    await checkedBiometric();
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
    if (!formKey.currentState!.validate()) return;

    AppUtils.showLoading();

    await Future.delayed(const Duration(milliseconds: 500));
    FocusScope.of(Get.context!).unfocus();

    await checkedUser();

    await userFirebaseRepository.reads().then((users) async {
      AppUtils.hideLoading();

      String deviceId = await AppUtils.getDeviceId();
      String phone = phoneController.text.trim();

      var foundUser = users.firstWhereOrNull((user) {
        return user.phone == phone && user.deviceId == deviceId;
      });
      if (foundUser == null) {
        AppUtils.showError('User not found'.tr);
        return;
      }

      String password = passwordController.text.trim();
      if (!password.verifyPassword(user.password)) {
        AppUtils.showError('Phone number or password is incorrect!'.tr);
        return;
      }

      await _handleCreateUser();
    });
  }

  Future<void> _handleCreateUser() async {
    var currentUser = user;
    var _user = UserModel.create(
      id: currentUser.id,
      phone: currentUser.phone,
      password: currentUser.password,
      name: currentUser.name.trim(),
      email: currentUser.email.trim(),
      address: currentUser.address.trim(),
      gender: currentUser.gender,
      profilePicture: currentUser.profilePicture,
      role: currentUser.role,
      dateOfBirth: currentUser.dateOfBirth,
      updatedAt: DateTime.now(),
      isLogin: true,
      deviceId: currentUser.deviceId,
      deviceToken: currentUser.deviceToken,
      deviceInfo: currentUser.deviceInfo,
    );

    await userRepository.update(_user);

    await userFirebaseRepository.update(_user).then((value) async {
      await Future.delayed(const Duration(milliseconds: 500));
      _onClear();

      Get.offAllNamed(AppRoutes.main);
    });
  }

  Future<void> _onClear() async {
    formKey.currentState?.reset();
    phoneController.clear();
    passwordController.clear();
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
    await biometricAuth();
  }

  Future<void> checkedBiometric() async {
    await Future.delayed(Duration(milliseconds: 300));

    await checkedUser();

    var availableBiometrics =
        await LocalAuthentication().getAvailableBiometrics();
    var isAvailable = await LocalAuthentication().canCheckBiometrics;

    showBiometric =
        user.enableBiometric && isAvailable && availableBiometrics.isNotEmpty;
  }

  Future<void> gotoRegister() async {
    Get.offAllNamed(AppRoutes.register);
    _onClear();
  }
}
