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
}
