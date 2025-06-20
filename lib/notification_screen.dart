import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Notifications'.tr,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              controller.onMarkasRead();
            },
          ),
        ],
        body: AppListview(
          onFreshing: () async {
            controller.onFreshing();
          },
          itemCount: controller.notifications.length,
          itemBuilder: (index) {
            final notification = controller.notifications[index];

            return ListTile(
              leading: CircleAvatar(child: Icon(FontAwesomeIcons.solidBell)),
              title: Text(notification.title, style: AppTextStyles.title),
              subtitle: Text(
                notification.message,
                style: AppTextStyles.subtitle,
              ),
              trailing: Text(
                notification.createdAt.format(pattern: "dd.MMM.yyyy"),
                style: AppTextStyles.caption,
              ),
              onTap: () => controller.onNotificationClick(index),
            );
          },
        ),
      ),
    );
  }
}
