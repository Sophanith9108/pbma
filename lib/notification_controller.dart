import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class NotificationController extends MainController {
  Future onNotificationClick(int index) async {
    showModalBottomSheet(
      context: Get.context!,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Notification $index', style: AppTextStyles.title),
              const SizedBox(height: 8),
              Text(
                'This is the description of notification $index',
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text('Close'.tr),
              ),
            ],
          ),
        );
      },
    );
  }
}
