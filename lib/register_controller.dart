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

  Future<void> onRegister() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();

      var user = UserModel.create(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
    }
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
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding,
                ),
                children: [Text(
                  "", style: AppTextStyles.text)],
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
                    'By agreeing to the privacy policy, you agree to our terms and conditions.',
                    style: AppTextStyles.text,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
