import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static Future<void> showLoading() async {
    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) {
        return Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  static Future<void> hideLoading() async {
    Get.back();
  }

  static void showError(String msg) {
    Get.snackbar(
      "Error".tr,
      msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static void showSuccess(String msg) {
    Get.snackbar(
      "Success".tr,
      msg,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  static void showInfo(String msg) {
    Get.snackbar(
      "Info".tr,
      msg,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  static void showWarning(String msg) {
    Get.snackbar(
      "Warning".tr,
      msg,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  static MaterialColor randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }
    return '';
  }

  static Future<String> getDeviceToken() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return "${iosInfo.identifierForVendor}.${DateTime.now().millisecondsSinceEpoch}";
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return "${androidInfo.id}.${DateTime.now().millisecondsSinceEpoch}";
    }
    return '';
  }
}
