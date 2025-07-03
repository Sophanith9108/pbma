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
    await _checkedUser();
    await onRetrieveTransactionFromFirebase();
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
                  await transactionRepository.delete(transaction.id);
                  await transactionFirebaseRepository.delete(transaction.id);
                  await onRetrieveTransactionFromFirebase();
                  AppUtils.hideLoading();
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
    await transactionFirebaseRepository.reads().then((value) async {
      transactions = value
          .where((element) {
            return element.createdBy.id == user.id;
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

  Future<void> _checkedUser() async {
    await userRepository.gets().then((value) {
      if (value != null && value.isNotEmpty) {
        user = value.first;
      }
    });
  }

  Future<void> gotoCreateTransaction() async {
    await Future.delayed(const Duration(milliseconds: 300));

    await userRepository.gets().then((value) {
      if (value == null || value.isEmpty || !value.first.isLogin) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      user = value.first;

      Get.toNamed(AppRoutes.createTransaction)?.then((result) {
        if (result != null && result) {
          setData();
        }
      });
    });
  }
}
