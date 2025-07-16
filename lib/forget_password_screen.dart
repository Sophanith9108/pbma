import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Forget Password'.tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.onForgetPassword(),
          label: Text("Forget Password".tr, style: AppTextStyles.button),
          icon: Icon(FontAwesomeIcons.passport),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              Text(
                'Please fulfill the form below to reset your password!'.tr,
                style: AppTextStyles.title,
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  labelText: 'Phone Number'.tr,
                  prefixIcon: Icon(FontAwesomeIcons.phone),
                  suffixIcon: IconButton(
                    onPressed: () => controller.phoneController.clear(),
                    icon: Icon(FontAwesomeIcons.xmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: controller.isPasswordVisible,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'New Password is required'.tr;
                  }
                  if (value.length < 8) {
                    return 'New Password must be at least 8 characters long'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'New Password'.tr,
                  prefixIcon: Icon(FontAwesomeIcons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isPasswordVisible =
                          !controller.isPasswordVisible;
                    },
                    icon: Icon(
                      controller.isPasswordVisible
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: controller.isConfirmPasswordVisible,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password is required'.tr;
                  }
                  if (value.length < 8) {
                    return 'Confirm Password must be at least 8 characters long'
                        .tr;
                  }
                  if (value != controller.passwordController.text) {
                    return 'Passwords do not match'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm Password'.tr,
                  prefixIcon: Icon(FontAwesomeIcons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isConfirmPasswordVisible =
                          !controller.isConfirmPasswordVisible;
                    },
                    icon: Icon(
                      controller.isConfirmPasswordVisible
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
