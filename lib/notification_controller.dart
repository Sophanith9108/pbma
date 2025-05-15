import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class NotificationController extends MainController {
  Future onNotificationClick(int index) async {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              Text('Notification $index', style: AppTextStyles.title),
              const SizedBox(height: 8),
              Text(
                'This is the description of notification $index',
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 8),
              Text(
                DateTime.now().format(pattern: "dd.MMM.yyyy hh:mm a"),
                style: AppTextStyles.caption,
              ),
            ],
          ),
        );
      },
    );
  }
}
