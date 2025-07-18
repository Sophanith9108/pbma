import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: "Settings".tr,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () => controller.onLanguageChanged(),
                    leading: Icon(FontAwesomeIcons.language),
                    title: Text("Languages".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "Change the language of the app".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Icon(FontAwesomeIcons.angleDown),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => controller.onThemeChanged(),
                    leading: Icon(FontAwesomeIcons.circleHalfStroke),
                    title: Text("Themes".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "Change the theme of the app".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Icon(FontAwesomeIcons.angleDown),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.bimobject),
                    title: Text("Biometric".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "Enable or disable using biometric".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Switch(
                      value: controller.enableBiometric,
                      onChanged: (value) {
                        controller.enableBiometric = value;
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.solidBell),
                    title: Text("Notifications".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "Enable or disable receiving notifications".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Switch(
                      value: controller.enableNotification,
                      onChanged: (value) {
                        controller.enableNotification = value;
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => controller.onAbout(),
                    leading: Icon(FontAwesomeIcons.solidBell),
                    title: Text("About".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "About the app".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Icon(FontAwesomeIcons.angleDown),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => controller.onTermsConditions(),
                    leading: Icon(FontAwesomeIcons.commentMedical),
                    title: Text(
                      "Terms & Conditions".tr,
                      style: AppTextStyles.title,
                    ),
                    subtitle: Text(
                      "To see our Terms & Conditions".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Icon(FontAwesomeIcons.angleDown),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => controller.onPrivacyPolicy(),
                    leading: Icon(FontAwesomeIcons.planeArrival),
                    title: Text(
                      "Privacy Policy".tr,
                      style: AppTextStyles.title,
                    ),
                    subtitle: Text(
                      "To see our Privacy Policy".tr,
                      style: AppTextStyles.subtitle,
                    ),
                    trailing: Icon(FontAwesomeIcons.angleDown),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () => controller.onLogout(),
                    leading: Icon(FontAwesomeIcons.explosion),
                    title: Text("Logout".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "Logout from the app".tr,
                      style: AppTextStyles.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Text(
              "Version: v${controller.version}(${controller.buildNumber})",
              style: AppTextStyles.subtitle,
            ),
            Text(
              "Copyright © ${DateTime.now().year} PBMA. All rights reserved.",
              style: AppTextStyles.subtitle,
            ),
            SizedBox(height: Get.width * .15),
          ],
        ),
      ),
    );
  }
}
