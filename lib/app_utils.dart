import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
}
