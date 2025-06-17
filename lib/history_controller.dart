import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HistoryController extends GetxController {
  final TransactionRepository transactionRepository = Get.put(
    TransactionRepository(),
  );

  final TransactionFirebaseRepository transactionFirebaseRepository = Get.put(
    TransactionFirebaseRepository(),
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

      await onRetrieveTransactionFromFirebase();
    });
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Fluttertoast.showToast(msg: "Done Refreshing!".tr);
      await onRetrieveTransactionFromFirebase();
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

                  await transactionRepository.delete(transaction.id);
                  await transactionFirebaseRepository.delete(transaction.id);
                  await onRetrieveTransactionFromFirebase();
                });
              },
              child: Text("Delete".tr, style: AppTextStyles.title),
            ),
          ],
        );
      },
    );
  }

  Future<void> onRetrieveTransactionFromFirebase() async {
    await transactionFirebaseRepository.gets().then((value) async {
      if (value != null) {
        transactions = value
            .groupListsBy((element) {
              return element.createdAt.format(pattern: AppConstants.dateFormat);
            })
            .map((key, value) {
              return MapEntry(key, value.reversed.toList());
            });

        var result = transactions.entries.toList().reversed.toList();
        transactions = Map.fromEntries(result);
      }
    });
  }
}
