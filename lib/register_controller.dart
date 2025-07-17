import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class RegisterController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _nameController = TextEditingController().obs;
  TextEditingController get nameController => _nameController.value;
  set nameController(TextEditingController value) =>
      _nameController.value = value;

  final _emailController = TextEditingController().obs;
  TextEditingController get emailController => _emailController.value;
  set emailController(TextEditingController value) =>
      _emailController.value = value;

  final _genderController = TextEditingController().obs;
  TextEditingController get genderController => _genderController.value;
  set genderController(TextEditingController value) =>
      _genderController.value = value;

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

  final _isAgreedWithTerms = false.obs;
  bool get isAgreedWithTerms => _isAgreedWithTerms.value;
  set isAgreedWithTerms(bool value) => _isAgreedWithTerms.value = value;

  final _profile = File('').obs;
  File get profile => _profile.value;
  set profile(File value) => _profile.value = value;

  final _addressController = TextEditingController().obs;
  TextEditingController get addressController => _addressController.value;
  set addressController(TextEditingController value) =>
      _addressController.value = value;

  final _selectedGender = GenderEnums.male.obs;
  GenderEnums get selectedGender => _selectedGender.value;
  set selectedGender(GenderEnums value) => _selectedGender.value = value;

  @override
  void onInit() {
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

  Future<void> onRegister() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(Get.context!).unfocus();

    if (!isAgreedWithTerms) {
      Fluttertoast.showToast(msg: 'Please agree with terms and conditions'.tr);
      return;
    }

    List<UserModel> userExist = await userFirebaseRepository.reads();
    String phone = phoneController.text.trim();
    bool isAlreadyRegistered = userExist.any((user) => user.phone == phone);
    if (isAlreadyRegistered) {
      Fluttertoast.showToast(
        msg: 'User with this phone number already exists!'.tr,
      );
      await Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.login);
      });
      return;
    }

    var profilePicture =
        profile.path.isNotEmpty ? base64Encode(profile.readAsBytesSync()) : "";

    String deviceId = await AppUtils.getDeviceId();
    String deviceToken = await AppUtils.getDeviceToken();
    String deviceInfo = await AppUtils.getDeviceInfo();

    var user = UserModel.create(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim().hashPassword(),
      address: addressController.text.trim(),
      profilePicture: profilePicture,
      dateOfBirth: DateTime.now().format(pattern: AppConstants.dateFormat),
      gender: selectedGender,
      role: UserRoleEnums.user,
      deviceId: deviceId,
      deviceToken: deviceToken,
      deviceInfo: deviceInfo,
      isLogin: true,
    );

    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3));
    await userRepository.save(user);
    await userFirebaseRepository
        .create(user)
        .then((response) async {
          AppUtils.hideLoading();

          user = response;

          await showEnableBiometric(user: user);
          await _onClear();
        })
        .catchError((error) {
          AppUtils.hideLoading();

          AppUtils.showError(error.toString());
        });
  }

  Future<void> onAgreeWithTerms() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Terms of Service'.tr,
                      style: AppTextStyles.title,
                    ),
                  ),
                  IconButton.outlined(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: AppDimensions.padding,
                  right: AppDimensions.padding,
                  bottom: AppDimensions.padding,
                ),
                children: [
                  Text(
                    'By agreeing to the terms of service, you agree to our terms and conditions.'
                    'Please read them carefully before proceeding.'
                    'If you do not agree with the terms, please do not use our services.'
                    'We reserve the right to modify these terms at any time, and it is your responsibility to review them periodically.'
                    'Your continued use of our services after any changes to the terms constitutes your acceptance of the new terms.'
                    'If you have any questions or concerns about the terms, please contact us.'
                    'Thank you for using our services.'
                    'We appreciate your understanding and cooperation.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.',
                    strutStyle: StrutStyle(height: 1.5),
                    style: AppTextStyles.text,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: Get.width * 0.1),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> onAgreeWithPolicy() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Privacy Policy'.tr,
                      style: AppTextStyles.title,
                    ),
                  ),
                  IconButton.outlined(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding,
                ),
                children: [
                  Text(
                    'By agreeing to the privacy policy, you agree to our terms and conditions.'
                    'Please read them carefully before proceeding.'
                    'If you do not agree with the terms, please do not use our services.'
                    'We reserve the right to modify these terms at any time, and it is your responsibility to review them periodically.'
                    'Your continued use of our services after any changes to the terms constitutes your acceptance of the new terms.'
                    'If you have any questions or concerns about the terms, please contact us.'
                    'Thank you for using our services.'
                    'We appreciate your understanding and cooperation.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We reserve the right to modify these terms at any time, and it is your responsibility to review them periodically.',
                    style: AppTextStyles.text,
                    strutStyle: StrutStyle(height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: Get.width * 0.1),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> onProfileUploaded() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showImagePicker((value) {
      if (value != null) {
        profile = File(value.path);
      }
    });
  }

  Future<void> onAddressSelected() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showMapSelectAddress((value) {
      addressController.text = value;
    });
  }

  Future<void> _onClear() async {
    await Future.delayed(const Duration(milliseconds: 300));

    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    formKey.currentState!.reset();

    nameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    addressController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
    isAgreedWithTerms = false;
  }

  Future<void> onGenderSelected() async {
    await Future.delayed(const Duration(milliseconds: 300));
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding),
          children:
              GenderEnums.values.map((gender) {
                return ListTile(
                  title: Text(
                    gender.name.capitalizeFirst!,
                    style: AppTextStyles.title,
                  ),
                  onTap: () {
                    genderController.text = gender.name.capitalizeFirst!;
                    user.gender = gender;
                    Get.back();
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
