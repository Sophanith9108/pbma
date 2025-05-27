import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      body: RefreshIndicator(
        onRefresh: () => controller.onRefreshing(),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(FontAwesomeIcons.moneyBillTransfer),
              title: Text(
                'Transaction ${index + 1}',
                style: AppTextStyles.title,
              ),
              subtitle: Text(
                DateTime.now().format(),
                style: AppTextStyles.subtitle,
              ),
              trailing: Text(
                '\$${(index + 1) * 1000}',
                style: AppTextStyles.amount,
              ),
              onTap: () => controller.showTransactionDetail(index),
            );
          },
        ),
      ),
    );
  }
}
