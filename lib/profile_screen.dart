import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Profile'.tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.onUserInfoUpdated(),
          label: Text('Edit Profile'.tr, style: AppTextStyles.button),
          icon: Icon(FontAwesomeIcons.penToSquare),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.gotoSettings(),
            icon: const Icon(FontAwesomeIcons.gear),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.all(AppDimensions.padding),
          children: [
            Center(
              child: Stack(
                children: [
                  Positioned(
                    child: Card.outlined(
                      elevation: AppDimensions.elevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Get.width),
                        side: BorderSide(
                          width: 2,
                          color: Colors.grey.withValues(alpha: .8),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Get.width),
                        child: SizedBox(
                          width: Get.width * .45,
                          height: Get.width * .45,
                          child:
                              controller.user.profilePicture.isNotEmpty
                                  ? Image.memory(
                                    base64Decode(
                                      controller.user.profilePicture,
                                    ),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    frameBuilder: (
                                      context,
                                      child,
                                      frame,
                                      wasSynchronouslyLoaded,
                                    ) {
                                      if (wasSynchronouslyLoaded) {
                                        return child;
                                      } else {
                                        return AnimatedOpacity(
                                          opacity: frame == null ? 0.0 : 1.0,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeOut,
                                          child: child,
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.person, size: 90);
                                    },
                                  )
                                  : Icon(
                                    FontAwesomeIcons.user,
                                    size: Get.width * .1,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton.outlined(
                      icon: const Icon(Icons.camera_alt),
                      color: Colors.white,
                      onPressed: () => controller.onProfileUploaded(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppDimensions.padding),
            TextFormField(
              controller: controller.nameController,
              readOnly: true,
              onTap: () {
                controller.onNameMessage();
              },
              decoration: InputDecoration(
                labelText: 'Name'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.padding),
            TextFormField(
              readOnly: true,
              controller: controller.genderController,
              onTap: () {
                controller.genderController.text.isNotEmpty
                    ? controller.onGenderMessage()
                    : controller.onGenderSelected();
              },
              decoration: InputDecoration(
                labelText: 'Gender'.tr,
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
              readOnly: true,
              onTap: () => controller.onEmailMessage(),
              decoration: InputDecoration(
                labelText: 'Email'.tr,
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
              readOnly: true,
              onTap: () => controller.onPhoneMessage(),
              decoration: InputDecoration(
                labelText: 'Phone'.tr,
                prefixText: "855 ",
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
              readOnly: true,
              onTap: () => controller.onAddressSelected(),
              decoration: InputDecoration(
                labelText: 'Address'.tr,
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
    );
  }
}
