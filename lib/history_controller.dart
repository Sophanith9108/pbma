import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HistoryController extends GetxController {
  final TransactionRepository transactionRepository = Get.put(
    TransactionRepository(),
  );

  final _transactions = <String, List<TransactionModel>>{}.obs;
  Map<String, List<TransactionModel>> get transactions => _transactions;
  set transactions(Map<String, List<TransactionModel>> value) =>
      _transactions.value = value;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    setData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setData() async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();
      await _initialized();
    });
  }

  Future<void> _initialized() async {
    var _transactions = await transactionRepository.gets() ?? [];
    transactions = _transactions
        .groupListsBy((element) {
          return element.createdAt.format(pattern: AppConstants.dateFormat);
        })
        .map((key, value) {
          return MapEntry(key, value.reversed.toList());
        });

    var result = transactions.entries.toList().reversed.toList();
    transactions = Map.fromEntries(result);
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Fluttertoast.showToast(msg: "Done Refreshing!".tr);
      await _initialized();
      return true;
    });
  }

  Future<void> onDeleteTransaction(TransactionModel transaction) async {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text("Delete Transaction".tr, style: AppTextStyles.title),
          content: Text(
            "Are you sure you want to delete this transaction?",
            style: AppTextStyles.value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel".tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () async {
                Get.back();

                AppUtils.showLoading();
                await Future.delayed(const Duration(seconds: 3), () async {
                  AppUtils.hideLoading();

                  await transactionRepository.delete(transaction.id!);
                  await _initialized();
                });
              },
              child: Text("Delete".tr, style: AppTextStyles.title),
            ),
          ],
        );
      },
    );
  }
}
