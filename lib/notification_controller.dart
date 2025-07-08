import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class NotificationController extends MainController {
  final _notifications = <NotificationModel>[].obs;
  List<NotificationModel> get notifications => _notifications;
  set notifications(List<NotificationModel> value) =>
      _notifications.value = value;

  @override
  void onInit() async {
    await onRetrievedNotifications();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future onNotificationClick(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));

    NotificationModel notification = notifications[index];
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: true,
      useSafeArea: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              left: AppDimensions.padding,
              right: AppDimensions.padding,
              bottom: AppDimensions.padding,
            ),
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Title".tr, style: AppTextStyles.label),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(notification.title, style: AppTextStyles.value),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Message".tr, style: AppTextStyles.label),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      notification.message,
                      style: AppTextStyles.value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Created By".tr, style: AppTextStyles.label),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      notification.createdBy.name,
                      style: AppTextStyles.value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Created At".tr, style: AppTextStyles.label),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      notification.createdAt.format(
                        pattern: "dd.MMM.yyyy hh:mm a",
                      ),
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onRetrievedNotifications() async {
    await notificationFirebaseRepository
        .reads()
        .then((value) {
          if (value.isNotEmpty) {
            notifications = value;
          } else {
            notifications = [];
          }
        })
        .catchError((error) {
          notifications = [];
        });
  }

  Future<void> onMarkasRead() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text('Mark all as read'.tr, style: AppTextStyles.title),
          content: Text(
            'Are you sure you want to mark all notifications as read?'.tr,
            style: AppTextStyles.text,
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'.tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () {
                for (var notification in notifications) {
                  notification.isRead = true;
                }

                Get.back();
              },
              child: Text('Mark as Read'.tr, style: AppTextStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> onFreshing() async {
    await Future.delayed(const Duration(seconds: 3));
    await onRetrievedNotifications();
  }
}
