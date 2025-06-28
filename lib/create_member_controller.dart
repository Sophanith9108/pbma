import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateMemberController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

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

  final _profile = File("").obs;
  File get profile => _profile.value;
  set profile(File value) => _profile.value = value;

  final _addressController = TextEditingController().obs;
  TextEditingController get addressController => _addressController.value;
  set addressController(TextEditingController value) =>
      _addressController.value = value;

  Future<void> onCreateMember() async {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(Get.context!).unfocus();

    var member = UserModel.create(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: "",
      address: addressController.text.trim(),

      profilePicture:
          profile.path.isNotEmpty
              ? base64Encode(profile.readAsBytesSync())
              : "",
      deviceId: '',
      deviceToken: '',
    );

    AppUtils.showLoading();
    await memberFirebaseRepository.create(member).then((value) async {
      AppUtils.hideLoading();

      Get.back(result: true);
      _onClear();
    });
  }

  Future<void> onProfileUploaded() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showImagePicker((value) {
      profile = File(value?.path ?? "");
    });
  }

  Future<void> onSelectAddress() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showMapSelectAddress((value) {
      addressController.text = value;
    });
  }

  void _onClear() {
    formKey.currentState!.reset();
    profile = File("");
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
  }
}
