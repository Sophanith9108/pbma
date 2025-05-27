import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Login'.tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.onLogin(),
          label: Text("Login".tr, style: AppTextStyles.button),
          icon: Icon(FontAwesomeIcons.arrowRightFromBracket),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.padding),
            children: [
              Text('Welcome back!'.tr, style: AppTextStyles.title),
              SizedBox(height: AppDimensions.spadding),
              Text(
                'Please enter your phone number and password to continue'.tr,
                style: AppTextStyles.subtitle,
              ),
              SizedBox(height: AppDimensions.xxlpadding),
              TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: '89267375'.tr,
                  labelText: 'Phone'.tr,
                  prefixIcon: const Icon(Icons.phone),
                  prefixText: '+855 ',
                  prefixStyle: AppTextStyles.label,

                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.phoneController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
                maxLines: 1,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                onChanged: (value) {
                  controller.phoneController.text = value;
                },
                onSaved: (value) {
                  controller.phoneController.text = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number'.tr;
                  }
                  if (value.length < 8) {
                    return 'Phone number must be at least 8 digits'.tr;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.passwordController,
                maxLines: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: InputDecoration(
                  labelText: 'Password'.tr,
                  prefixIcon: const Icon(Icons.lock),
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: '********'.tr,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.passwordController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                onChanged: (value) {
                  controller.passwordController.text = value;
                },
                onSaved: (value) {
                  controller.passwordController.text = value!;
                },
                validator: (value) {
                  final weakPasswords = {
                    '123456',
                    'password',
                    'qwerty',
                    'abc123',
                    'letmein',
                    'welcome',
                    'admin',
                    'user',
                    'test',
                    'guest',
                    '12345678',
                    '123456789',
                    '1234567890',
                    '12345678901',
                    '123456789012',
                    '1234567890123',
                    '12345678901234',
                    '123456789012345',
                    '1234567890123456',
                    '12345678901234567',
                  };

                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'.tr;
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters'.tr;
                  }
                  if (value.length > 20) {
                    return 'Password must be at most 20 characters'.tr;
                  }
                  if (!RegExp(
                    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$',
                  ).hasMatch(value)) {
                    return 'Password must contain at least one letter, one number,\nand one special character'
                        .tr;
                  }
                  if (value.contains(' ')) {
                    return 'Password must not contain spaces'.tr;
                  }
                  if (weakPasswords.contains(value)) {
                    return 'Password is too weak'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.padding),
            ],
          ),
        ),
      ),
    );
  }
}
