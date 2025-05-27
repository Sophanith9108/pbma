import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HistoryController extends GetxController {
  Future<void> onRefreshing() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Future<void> showTransactionDetail(int index) async {
    await Future.delayed(Duration(milliseconds: 300));
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Transaction $index', style: AppTextStyles.title),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      Get.back();
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(AppDimensions.padding),
                  children: [
                    Text('Lorem Ipsum', style: AppTextStyles.text),
                    Text('Lorem Ipsum', style: AppTextStyles.text),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
