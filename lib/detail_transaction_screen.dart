import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class DetailTransactionScreen extends StatelessWidget {
  DetailTransactionScreen({super.key});

  final DetailTransactionController controller =
      Get.find<DetailTransactionController>();

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      title: 'Detail Transaction'.tr,
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.padding),
        children: [Text('Detail Transaction'.tr, style: AppTextStyles.title)],
      ),
    );
  }
}
