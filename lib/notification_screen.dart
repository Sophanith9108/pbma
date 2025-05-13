import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      title: 'Notifications'.tr,
      actions: [
        IconButton(icon: const Icon(Icons.clear_all), onPressed: () {}),
      ],
      body: AppListview(
        onFreshing: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        itemCount: 20,
        itemBuilder:
            (index) => ListTile(
              leading: const Icon(Icons.notifications),
              title: Text('Notification $index', style: AppTextStyles.title),
              subtitle: Text(
                'This is the description of notification $index',
                style: AppTextStyles.subtitle,
              ),
              trailing: Text(
                DateTime.now().format(pattern: "dd.MMM.yyyy"),
                style: AppTextStyles.caption,
              ),
              onTap: () => controller.onNotificationClick(index),
            ),
      ),
    );
  }
}
