import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class BudgetScreen extends StatelessWidget {
  BudgetScreen({super.key});

  final BudgetController controller = Get.put(BudgetController());

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      body: Center(child: Text('This is the Budget Screen'.tr)),
    );
  }
}
