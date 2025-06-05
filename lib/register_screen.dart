import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Register'.tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.onRegister(),
          label: Text('Register'.tr, style: AppTextStyles.button),
          icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.padding),
            children: [
              Text('Register'.tr, style: AppTextStyles.title),
              const SizedBox(height: 8),
              Text(
                'Please fill in the form below to create an account'.tr,
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: AppDimensions.padding),
              CircleAvatar(
                radius: Get.width * 0.15,
                backgroundColor: AppColors.primary,
                child:
                    controller.profile.path.isEmpty
                        ? IconButton(
                          icon: const Icon(Icons.camera_alt),
                          color: Colors.white,
                          onPressed: () => controller.onProfileUploaded(),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(Get.width),
                          child: Image.file(
                            File(controller.profile.path),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            width: Get.width * 0.3,
                            height: Get.width * 0.3,
                          ),
                        ),
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.nameController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: 'John Doe'.tr,
                  labelText: 'Name'.tr,
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.nameController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  LengthLimitingTextInputFormatter(50),
                ],
                maxLines: 1,
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.emailController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'.tr;
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: 'asdasdasd.9108@gmail.com'.tr,
                  labelText: 'Email'.tr,
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.emailController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  LengthLimitingTextInputFormatter(50),
                ],
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.phoneController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number'.tr;
                  }
                  if (value.length < 8) {
                    return 'Phone number must be at least 8 digits'.tr;
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.length > 8) {
                    controller.phoneController.text = value.substring(0, 8);
                  }
                },
                onFieldSubmitted: (value) {
                  if (controller.formKey.currentState!.validate()) {
                    controller.phoneController.text = value;
                  }
                },
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
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.passwordController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password'.tr;
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: '********'.tr,
                  labelText: 'Password'.tr,
                  prefixIcon: const Icon(Icons.lock),
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
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.confirmPasswordController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your confirm password'.tr;
                  }
                  if (value.length < 8) {
                    return 'Confirm password must be at least 8 characters'.tr;
                  }
                  if (value != controller.passwordController.text) {
                    return 'Passwords do not match'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: '********'.tr,
                  labelText: 'Confirm Password'.tr,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.confirmPasswordController.clear();
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
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.addressController,
                readOnly: true,
                onTap: () => controller.onAddressSelected(),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: '123 Street, City, Country'.tr,
                  labelText: 'Address'.tr,
                  prefixIcon: const Icon(Icons.home),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.addressController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Checkbox(
                    value: controller.isAgreedWithTerms,
                    onChanged: (value) {
                      controller.isAgreedWithTerms = value!;
                    },
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: ' ',
                        style: AppTextStyles.subtitle,
                        children: [
                          TextSpan(
                            text: 'I am agree with'.tr,
                            style: AppTextStyles.button,
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.isAgreedWithTerms =
                                        !controller.isAgreedWithTerms;
                                  },
                          ),
                          TextSpan(text: " "),
                          TextSpan(
                            text: 'Terms of Service'.tr,
                            style: AppTextStyles.link,
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.onAgreeWithTerms();
                                  },
                          ),
                          TextSpan(
                            text: ' and ',
                            style: AppTextStyles.subtitle,
                          ),
                          TextSpan(
                            text: 'Privacy Policy'.tr,
                            style: AppTextStyles.link,
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    controller.onAgreeWithPolicy();
                                  },
                          ),
                          TextSpan(text: '.', style: AppTextStyles.subtitle),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.width * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
