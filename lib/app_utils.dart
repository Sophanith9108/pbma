import 'dart:convert';
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

  static Future<String> getDeviceName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }
    return '';
  }

  static Future<String> getDeviceModel() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    }
    return '';
  }

  static Future<String> getDeviceOS() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemName;
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.baseOS ?? '';
    }
    return '';
  }

  static Future<String> getDeviceVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return iosInfo.systemVersion;
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    }
    return '';
  }

  static Future<String> getDeviceInfo() async {
    var deviceInfo = DeviceInfoPlugin();
    if (GetPlatform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      return jsonEncode({
        "deviceName": iosInfo.name,
        "deviceModel": iosInfo.model,
        "deviceOS": iosInfo.systemName,
        "deviceVersion": iosInfo.systemVersion,
      });
    } else if (GetPlatform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      return jsonEncode({
        "deviceName": androidInfo.model,
        "deviceModel": androidInfo.model,
        "deviceOS": androidInfo.version.baseOS ?? '',
        "deviceVersion": androidInfo.version.release,
      });
    }
    return '';
  }

  static Future<void> delay({int milliseconds = 300}) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
