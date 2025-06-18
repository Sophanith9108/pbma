import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class BudgetController extends GetxController {
  final BudgetRepository budgetRepository = Get.put(BudgetRepository());
  final BudgetFirebaseRepository budgetFirebaseRepository = Get.put(
    BudgetFirebaseRepository(),
  );

  final _budgets = <BudgetModel>[].obs;
  List<BudgetModel> get budgets => _budgets;
  set budgets(List<BudgetModel> value) => _budgets.value = value;

  @override
  void onInit() {
    setData();
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
    budgets = await budgetFirebaseRepository.gets() ?? [];
    if (budgets.isEmpty) {
      budgets = BudgetModel.mockup();
    }
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await setData();
      return true;
    });
  }

  Future<void> gotoCreateBudget() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Get.toNamed(AppRoutes.createBudget)?.then((result) {
      if (result != null && result) {
        setData();
      }
    });
  }

  Future<void> onBudgetClicked(int index) async {
    BudgetModel budget = budgets[index];

    await Future.delayed(const Duration(milliseconds: 300));
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            left: AppDimensions.padding,
            right: AppDimensions.padding,
            bottom: AppDimensions.xxxlpadding,
          ),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("ID".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 3,
                  child: Text(budget.id, style: AppTextStyles.value),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.padding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Title".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    budget.name.toUpperCase(),
                    style: AppTextStyles.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.padding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Amount".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "${budget.amount.toStringAsFixed(2)} ${budget.currency.name}",
                    style: AppTextStyles.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.padding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Started At".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    budget.date.format(pattern: AppConstants.dateFormat),
                    style: AppTextStyles.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.padding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Created At".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    budget.createdAt.format(
                      pattern: AppConstants.budgetDateTimeFormat,
                    ),
                    style: AppTextStyles.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.padding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Updated At".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    budget.updatedAt.format(
                      pattern: AppConstants.budgetDateTimeFormat,
                    ),
                    style: AppTextStyles.value,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> onLongPress(int index) async {
    var budget = budgets[index];

    await Future.delayed(const Duration(milliseconds: 300));
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text("Delete".tr, style: AppTextStyles.title),
          content: Text.rich(
            TextSpan(
              text: "Are you sure you want to delete".tr,
              style: AppTextStyles.value,
              children: [
                TextSpan(text: " "),
                TextSpan(text: budget.name, style: AppTextStyles.header1),
                TextSpan(text: "?"),
              ],
            ),
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
                await Future.delayed(const Duration(seconds: 1), () async {
                  await budgetFirebaseRepository.delete(budget.id);
                  await setData();

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
}
