import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Profile'.tr,
        body: ListView(
          padding: EdgeInsets.all(AppDimensions.padding),
          children: [
            SizedBox(
              height: 150,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CircleAvatar(
                      child: Image.file(
                        File(controller.user.profilePicture ?? ""),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Center(child: Icon(Icons.person, size: 90)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton.outlined(
                      icon: Icon(Icons.camera_alt, size: 30),
                      onPressed: () {
                        
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
