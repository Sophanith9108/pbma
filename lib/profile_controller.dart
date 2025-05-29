import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileController extends MainController {
  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

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
    List<UserModel> users = await userRepository.gets() ?? [];
    if (users.isNotEmpty) {
      user = users.first;
      genderController.text = user.gender.value;
      addressController.text = user.address;
    } else {
      user = UserModel();
    }
  }

  Future<void> onProfileUploaded() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showImagePicker((value) {
      user.profilePicture = value?.path ?? "";
      profile = File(value?.path ?? "");
    });
  }

  Future<void> onUserInfoUpdated() async {
    AppUtils.showLoading();
    await Future.delayed(Duration(seconds: 3), () {
      AppUtils.hideLoading();
      AppUtils.showSuccess(
        "The user information has been updated successfully.".tr,
      );
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
}
