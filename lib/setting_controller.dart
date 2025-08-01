import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pbma/core.dart';

class SettingController extends MainController {
  final _enableBiometric = false.obs;
  bool get enableBiometric => _enableBiometric.value;
  set enableBiometric(bool value) => _enableBiometric.value = value;

  final _enableNotification = false.obs;
  bool get enableNotification => _enableNotification.value;
  set enableNotification(bool value) => _enableNotification.value = value;

  final _version = "".obs;
  String get version => _version.value;
  set version(String value) => _version.value = value;

  final _buildNumber = "".obs;
  String get buildNumber => _buildNumber.value;
  set buildNumber(String value) => _buildNumber.value = value;

  @override
  void onInit() async {
    await _setData();

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    await _setData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _setData() async {
    await _handleCurrentVersion();
    await _handleEnableBiometric();
    await _handleEnableNotification();
  }

  Future<void> _handleCurrentVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    } catch (e) {
      version = "Unknown";
      buildNumber = "Unknown";
    }
  }

  Future<void> _handleEnableBiometric() async {
    enableBiometric = await userRepository.get(user.id).then((value) {
      if (value != null) {
        return value.enableBiometric;
      }
      return false;
    });
  }

  Future<void> _handleEnableNotification() async {
    await AppUtils.delay();

    enableNotification = await settingsRepository.get(settings.id).then((
      value,
    ) {
      AppUtils.logging(settings.id);
      AppUtils.logging(value?.enableNotification);
      if (value != null) {
        return value.enableNotification;
      }
      return false;
    });
  }

  Future<void> onLanguageChanged() async {
    await AppUtils.delay();

    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              LanguagesEnum.values.map((element) {
                return ListTile(
                  leading: Icon(element.icon),
                  title: Text(element.name, style: AppTextStyles.title),
                  subtitle: Text(
                    "To change to ${element.name}".tr,
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () async {
                    await AppUtils.delay();
                    Get.back();
                    await _handleSaveLanguage(element);
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onThemeChanged() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              ThemeMode.values.map((element) {
                IconData icon;
                switch (element) {
                  case ThemeMode.light:
                    icon = FontAwesomeIcons.sun;
                  case ThemeMode.dark:
                    icon = FontAwesomeIcons.moon;
                  case ThemeMode.system:
                    icon = FontAwesomeIcons.circleHalfStroke;
                }

                return ListTile(
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    Get.back();
                    Get.changeThemeMode(element);
                    await _handleSaveTheme(element);
                  },
                  leading: Icon(icon),
                  title: Text(
                    element.name.capitalizeFirst!,
                    style: AppTextStyles.title,
                  ),
                  subtitle: Text(
                    "To change to ${element.name}".tr,
                    style: AppTextStyles.subtitle,
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onLogout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text("Logout".tr, style: AppTextStyles.title),
          content: Text(
            "Are you sure you want to logout?".tr,
            style: AppTextStyles.value,
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel".tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () async {
                Get.back();

                await _handleLogout();
              },
              child: Text("Logout".tr, style: AppTextStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    await Future.delayed(const Duration(milliseconds: 300));

    user.isLogin = false;

    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3));

    await userRepository.update(user);
    await userFirebaseRepository.update(user).then((value) async {
      user = value;

      await checkedUser();

      await homeController.onRefreshing();
      await transactionController.onRefreshing();
      await memberController.onRefreshing();
      await budgetController.onRefreshing();
      await accountController.onRefreshing();

      AppUtils.hideLoading();

      Get.offAllNamed(AppRoutes.main);
    });
  }

  Future<void> onAbout() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return Column(
          children: [
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text("ABOUT US ".tr, style: AppTextStyles.title),
                    subtitle: Text(
                      "We are happy to let u guys know us!".tr,
                      style: AppTextStyles.value,
                    ),
                  ),
                ),
                IconButton.outlined(
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    Get.back();
                  },
                  icon: Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(AppDimensions.padding),
                shrinkWrap: true,
                children: [
                  Text.rich(
                    style: AppTextStyles.value,
                    textAlign: TextAlign.justify,
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.width * .15),
          ],
        );
      },
    );
  }

  Future<void> onTermsConditions() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return Column(
          children: [
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "TERMS & CONDITIONS".tr,
                      style: AppTextStyles.title,
                    ),
                    subtitle: Text(
                      "There are the terms and conditions!".tr,
                      style: AppTextStyles.value,
                    ),
                  ),
                ),
                IconButton.outlined(
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    Get.back();
                  },
                  icon: Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(AppDimensions.padding),
                shrinkWrap: true,
                children: [
                  Text.rich(
                    style: AppTextStyles.value,
                    textAlign: TextAlign.justify,
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.width * .15),
          ],
        );
      },
    );
  }

  Future<void> onPrivacyPolicy() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return Column(
          children: [
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "PRIVACY POLICY".tr,
                      style: AppTextStyles.title,
                    ),
                    subtitle: Text(
                      "There are the privacy policy!".tr,
                      style: AppTextStyles.value,
                    ),
                  ),
                ),
                IconButton.outlined(
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    Get.back();
                  },
                  icon: Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(AppDimensions.padding),
                shrinkWrap: true,
                children: [
                  Text.rich(
                    style: AppTextStyles.value,
                    textAlign: TextAlign.justify,
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                        TextSpan(
                          text:
                              "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.width * .15),
          ],
        );
      },
    );
  }

  Future<void> _handleSaveLanguage(LanguagesEnum element) async {
    await AppUtils.delay();

    settings.language = element;

    AppUtils.showLoading();
    await AppUtils.delay(milliseconds: 1000);
    await settingsRepository.save(settings).then((value) async {
      AppUtils.hideLoading();

      await onSetupConfigs();
    });
  }

  Future<void> _handleSaveTheme(ThemeMode element) async {
    await AppUtils.delay();

    settings.theme = element.name;

    AppUtils.showLoading();
    await AppUtils.delay(milliseconds: 1000);
    await settingsRepository.save(settings).then((value) async {
      AppUtils.hideLoading();

      await onSetupConfigs();
    });
  }

  Future<void> onBiometricChanged(bool value) async {
    enableBiometric = value;
    user.enableBiometric = enableBiometric;

    await _handleSavedBiometric();
  }

  Future<void> _handleSavedBiometric() async {
    AppUtils.showLoading();
    await AppUtils.delay(milliseconds: 1000);
    await userRepository.update(user).then((value) async {
      await _handleEnableBiometric();
      await onSetupConfigs();
      AppUtils.hideLoading();
    });
  }

  Future<void> onNotificationChanged(bool value) async {
    enableNotification = value;
    settings.enableNotification = enableNotification;
    await _handleSavedNotification();
  }

  Future<void> _handleSavedNotification() async {
    AppUtils.showLoading();
    await AppUtils.delay(milliseconds: 1000);
    await settingsRepository.update(settings).then((value) async {
      await _handleEnableNotification();
      AppUtils.hideLoading();
    });
  }
}
