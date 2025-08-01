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

  final _currentUser = UserModel().obs;
  UserModel get currentUser => _currentUser.value;
  set currentUser(UserModel value) => _currentUser.value = value;

  @override
  void onInit() async {
    await checkedUser();
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

    await AppUtils.delay();
    FocusScope.of(Get.context!).unfocus();

    AppUtils.showLoading();
    await userFirebaseRepository.reads().then((users) async {
      AppUtils.hideLoading();

      String phone = phoneController.text.trim();
      UserModel? foundUser = users.firstWhereOrNull(
        (user) => user.phone == phone,
      );
      if (foundUser == null) {
        AppUtils.showError('User not found'.tr);
        await AppUtils.delay();
        await _onClear();
        return;
      }

      currentUser = foundUser;

      String password = passwordController.text.trim();
      if (!password.verifyPassword(currentUser.password)) {
        AppUtils.showError('Phone number or password is incorrect!'.tr);
        return;
      }

      await _handleCreateUser(currentUser);
    });
  }

  Future<void> _handleCreateUser(UserModel currentUser) async {
    String deviceId = await AppUtils.getDeviceId();
    String deviceToken = await AppUtils.getDeviceToken();
    String deviceInfo = await AppUtils.getDeviceInfo();

    UserModel _user = UserModel.create(
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
      deviceId: deviceId,
      deviceToken: deviceToken,
      deviceInfo: deviceInfo,
      enableBiometric: currentUser.enableBiometric,
    );

    AppUtils.showLoading();
    await userRepository.update(_user);
    await userFirebaseRepository.update(_user).then((value) async {
      user = value;
      await setData();

      await homeController.onRefreshing();
      await accountController.onRefreshing();
      await transactionController.onRefreshing();
      await memberController.onRefreshing();
      await budgetController.onRefreshing();

      AppUtils.hideLoading();

      if (!user.enableBiometric) {
        await showDialogEnableBiometric(user: user);
      } else {
        Get.offAllNamed(AppRoutes.main);
      }

      await _onClear();
    });
  }

  Future<void> _onClear() async {
    formKey.currentState?.reset();
    phoneController.clear();
    passwordController.clear();
  }

  Future<void> gotoForgotPassword() async {
    await Future.delayed(Duration(milliseconds: 300));
    Get.offAllNamed(AppRoutes.forgetPassword);
  }

  Future<void> loginWithBiometrics() async {
    await Future.delayed(Duration(milliseconds: 300));
    await checkedUser();
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

  Future<void> biometricAuth() async {
    final localAuth = LocalAuthentication();

    try {
      AppUtils.showLoading();

      final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to login'.tr,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        AppUtils.hideLoading();

        await _handleCreateUser(user);
      } else {
        AppUtils.hideLoading();
        AppUtils.showError('Authentication failed'.tr);
      }
    } catch (e) {
      AppUtils.hideLoading();
      AppUtils.showError('Authentication failed'.tr);
    }
  }

  Future<void> gotoRegister() async {
    Get.offAllNamed(AppRoutes.register);
    _onClear();
  }
}
