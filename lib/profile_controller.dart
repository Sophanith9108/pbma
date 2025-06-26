import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileController extends MainController {
  final _profile = File("").obs;
  File get profile => _profile.value;
  set profile(File value) => _profile.value = value;

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
    await setData();
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

  void setView(UserModel user) {
    genderController.text = user.gender.value.tr;
    addressController.text = user.address;
  }

  Future<void> onProfileUploaded() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showImagePicker((value) {
      profile = File(value?.path ?? "");
      user.profilePicture = base64Encode(profile.readAsBytesSync());
    });
  }

  Future<void> onUserInfoUpdated() async {
    AppUtils.showLoading();
    await Future.delayed(Duration(seconds: 3), () async {
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
    await Future.delayed(const Duration(milliseconds: 300));
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              GenderEnums.values.map((element) {
                return ListTile(
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
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
    await Future.delayed(Duration(milliseconds: 300));
    await showMapSelectAddress((value) {
      addressController.text = value;
    });
  }

  Future<void> onGenderMessage() async {
    await Future.delayed(const Duration(milliseconds: 300));
    AppUtils.showWarning("Gender cannot be changed!".tr);
  }

  void onNameMessage() async {
    await Future.delayed(const Duration(milliseconds: 300));
    AppUtils.showWarning("Name cannot be changed!".tr);
  }

  void onEmailMessage() async {
    await Future.delayed(const Duration(milliseconds: 300));
    AppUtils.showWarning("Email cannot be changed!".tr);
  }

  void onPhoneMessage() async {
    await Future.delayed(const Duration(milliseconds: 300));
    AppUtils.showWarning("Phone number cannot be changed!".tr);
  }

  Future<void> onLogout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text("Logout".tr, style: AppTextStyles.title),
          content: Text(
            "Are you sure you want to logout?".tr,
            style: AppTextStyles.value,
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel".tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                handleLogout();
              },
              child: Text("Logout".tr, style: AppTextStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleLogout() async {
    user.isLogin = false;
    AppUtils.showLoading();
    await userFirebaseRepository.update(user);
    await userRepository.update(user).then((_) {
      AppUtils.hideLoading();
      Get.offAllNamed(AppRoutes.login);
    });
  }
}
