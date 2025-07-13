import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HistoryController extends GetxController {
  final TransactionRepository transactionRepository = Get.put(
    TransactionRepository(),
  );

  final TransactionFirebaseRepository transactionFirebaseRepository = Get.put(
    TransactionFirebaseRepository(),
  );

  final UserRepository userRepository = Get.put(UserRepository());

  final _transactions = <String, List<TransactionModel>>{}.obs;
  Map<String, List<TransactionModel>> get transactions => _transactions;
  set transactions(Map<String, List<TransactionModel>> value) =>
      _transactions.value = value;

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  @override
  void onInit() async {
    await setData();
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

  Future<void> setData() async {
    await checkedUser();
    await onRetrivedTransactions();
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await setData();
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
                  await onRetrivedTransactions();
                });
              },
              child: Text("Delete".tr, style: AppTextStyles.title),
            ),
          ],
        );
      },
    );
  }

  Future<void> onRetrivedTransactions() async {
    await transactionFirebaseRepository.reads().then((value) async {
      transactions = value
          .where((element) {
            return element.createdBy.id == user.id && user.isLogin;
          })
          .groupListsBy((element) {
            return element.createdAt.format(pattern: AppConstants.dateFormat);
          })
          .map((key, value) {
            return MapEntry(key, value.reversed.toList());
          });

      var result = transactions.entries.toList().reversed.toList();
      transactions = Map.fromEntries(result);
    });
  }

  Future<void> gotoCreateTransaction() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await checkedUser();

    Get.toNamed(AppRoutes.createTransaction)?.then((result) async {
      if (result != null && result) {
        await setData();
      }
    });
  }

  Future<void> checkedUser() async {
    var users = await userRepository.gets() ?? [];
    if (users.isNotEmpty) {
      user = users.first;
    }
  }
}
