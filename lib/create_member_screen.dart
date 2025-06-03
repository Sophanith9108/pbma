import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateMemberScreen extends StatelessWidget {
  CreateMemberScreen({super.key});

  final CreateMemberController controller = Get.put(CreateMemberController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Create Member'.tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.onCreateMember(),
          label: Text("Create Member".tr, style: AppTextStyles.button),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              Text('Create Member'.tr, style: AppTextStyles.title),
              SizedBox(height: AppDimensions.spadding),
              Text(
                'Please fill in the form below to create a member'.tr,
                style: AppTextStyles.subtitle,
              ),
              SizedBox(height: AppDimensions.padding),
              CircleAvatar(
                radius: Get.width * 0.15,
                backgroundColor: AppColors.primary,
                backgroundImage: FileImage(controller.profile),
                onBackgroundImageError: (exception, stackTrace) => Container(),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.white,
                  onPressed: () => controller.onProfileUploaded(),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Full Name is required".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Full Name".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Full Name".tr,
                  hintStyle: AppTextStyles.hint,
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.nameController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
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
                controller: controller.phoneController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(?!0\d)\d*(\.\d{0,2})?$'),
                  ),
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone is required".tr;
                  }
                  if (!GetUtils.isPhoneNumber(value)) {
                    return "Phone is not valid".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Phone number".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Phone number".tr,
                  hintStyle: AppTextStyles.hint,
                  prefixIcon: const Icon(Icons.phone),
                  prefixText: '+855 ',
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.phoneController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
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
                controller: controller.emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required".tr;
                  }
                  if (!GetUtils.isEmail(value)) {
                    return "Email is not valid".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Email".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Email".tr,
                  hintStyle: AppTextStyles.hint,
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.emailController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
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
                controller: controller.addressController,
                onTap: () {
                  controller.onSelectAddress();
                },
                readOnly: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address is required".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Address".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Address".tr,
                  hintStyle: AppTextStyles.hint,
                  prefixIcon: const Icon(Icons.location_on),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.addressController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.width * .2),
            ],
          ),
        ),
      ),
    );
  }
}
