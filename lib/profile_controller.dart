import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileController extends MainController {
  final _profile = File("").obs;
  File get profile => _profile.value;
  set profile(File value) => _profile.value = value;

  final _nameController = TextEditingController().obs;
  TextEditingController get nameController => _nameController.value;
  set nameController(TextEditingController value) =>
      _nameController.value = value;

  final _phoneController = TextEditingController().obs;
  TextEditingController get phoneController => _phoneController.value;
  set phoneController(TextEditingController value) =>
      _phoneController.value = value;

  final _emailController = TextEditingController().obs;
  TextEditingController get emailController => _emailController.value;
  set emailController(TextEditingController value) =>
      _emailController.value = value;

  final _genderController = TextEditingController().obs;
  TextEditingController get genderController => _genderController.value;
  set genderController(TextEditingController value) =>
      _genderController.value = value;

  final _addressController = TextEditingController().obs;
  TextEditingController get addressController => _addressController.value;
  set addressController(TextEditingController value) =>
      _addressController.value = value;

  @override
  void onInit() async {
    await checkedUser();
    await setView();

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    await checkedUser();
    await setView();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setView() async {
    await checkedUser();

    profile = File(user.profilePicture);
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
    genderController.text = user.gender.value;
    addressController.text = user.address;
  }

  Future<void> onProfileUploaded() async {
    await AppUtils.delay();
    await showImagePicker((value) {
      profile = File(value?.path ?? "");
      user.profilePicture = base64Encode(profile.readAsBytesSync());
    });
  }

  Future<void> onUserInfoUpdated() async {
    AppUtils.showLoading();
    await Future.delayed(Duration(seconds: 1), () async {
      AppUtils.hideLoading();

      user.profilePicture = base64Encode(profile.readAsBytesSync());
      user.updatedAt = DateTime.now();
      user.isLogin = true;
      userRepository.update(user);

      await userFirebaseRepository.update(user);

      Get.back(result: true);
    });
  }

  Future<void> onGenderSelected() async {
    await AppUtils.delay();
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              GenderEnums.values.map((element) {
                return ListTile(
                  onTap: () async {
                    await AppUtils.delay();
                    user.gender = element;
                    genderController.text = element.value.tr;
                    Get.back();
                  },
                  title: Text(
                    element.name.capitalizeFirst!.tr,
                    style: AppTextStyles.title,
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onAddressSelected() async {
    await AppUtils.delay();
    await showMapSelectAddress((value) {
      addressController.text = value;
    });
  }

  Future<void> onGenderMessage() async {
    await AppUtils.delay();
    AppUtils.showWarning("Gender cannot be changed!".tr);
  }

  void onNameMessage() async {
    await AppUtils.delay();
    AppUtils.showWarning("Name cannot be changed!".tr);
  }

  void onEmailMessage() async {
    await AppUtils.delay();
    AppUtils.showWarning("Email cannot be changed!".tr);
  }

  void onPhoneMessage() async {
    await AppUtils.delay();
    AppUtils.showWarning("Phone number cannot be changed!".tr);
  }

  Future<void> gotoSettings() async {
    await AppUtils.delay();
    Get.toNamed(AppRoutes.settings);
  }
}
