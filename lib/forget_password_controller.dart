import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ForgetPasswordController extends MainController {
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

  final _confirmPasswordController = TextEditingController().obs;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController.value;
  set confirmPasswordController(TextEditingController value) =>
      _confirmPasswordController.value = value;

  final _isPasswordVisible = true.obs;
  bool get isPasswordVisible => _isPasswordVisible.value;
  set isPasswordVisible(bool value) => _isPasswordVisible.value = value;

  final _isConfirmPasswordVisible = true.obs;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible.value;
  set isConfirmPasswordVisible(bool value) =>
      _isConfirmPasswordVisible.value = value;

  Future<void> onForgetPassword() async {
    await Future.delayed(Duration(milliseconds: 300));

    if (!formKey.currentState!.validate()) return;

    var phone = phoneController.text.trim();
    var password = passwordController.text.trim();

    AppUtils.showLoading();
    await Future.delayed(Duration(seconds: 3));
    var users = await forgetPasswordRepository.reads();
    var foundUser = users.firstWhereOrNull((user) => user.phone == phone);
    AppUtils.hideLoading();

    if (foundUser == null) {
      AppUtils.showError('User not found'.tr);
      await _onClear();
      return;
    }

    await checkedUser();

    var deviceId = await AppUtils.getDeviceId();
    var deviceToken = await AppUtils.getDeviceToken();
    var deviceInfo = await AppUtils.getDeviceInfo();

    var _user = UserModel.create(
      id: foundUser.id,
      name: foundUser.name,
      email: foundUser.email,
      phone: phone,
      password: password.hashPassword(),
      address: foundUser.address,
      deviceId: deviceId,
      deviceToken: deviceToken,
      deviceInfo: deviceInfo,
      profilePicture: foundUser.profilePicture,
      dateOfBirth: foundUser.dateOfBirth,
      gender: foundUser.gender,
      role: foundUser.role,
      isLogin: false,
      enableBiometric: foundUser.enableBiometric,
      status: foundUser.status,
    );

    AppUtils.showLoading();
    await forgetPasswordRepository
        .create(_user)
        .then(
          (user) async {
            AppUtils.hideLoading();

            await userRepository.update(user);

            _onClear();
            Get.offAllNamed(AppRoutes.login);
          },
          onError: (error) {
            AppUtils.hideLoading();
            AppUtils.showError(error.toString());
          },
        );
  }

  Future<void> _onClear() async {
    formKey.currentState!.reset();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isPasswordVisible = true;
    isConfirmPasswordVisible = true;
  }
}
