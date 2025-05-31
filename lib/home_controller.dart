import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeController extends GetxController {
  final UserRepository userRepository = Get.put(UserRepository());
  final TargetRepository targetRepository = Get.put(TargetRepository());

  final _startDate = DateTime.now().obs;
  DateTime get startDate => _startDate.value;
  set startDate(DateTime value) => _startDate.value = value;

  final _endDate = DateTime.now().obs;
  DateTime get endDate => _endDate.value;
  set endDate(DateTime value) => _endDate.value = value;

  final _targetAmount = 300.0.obs;
  double get targetAmount => _targetAmount.value;
  set targetAmount(double value) => _targetAmount.value = value;

  final _currency = CurrencyEnums.values.first.obs;
  CurrencyEnums get currency => _currency.value;
  set currency(CurrencyEnums value) => _currency.value = value;

  final _currentAmount = 0.0.obs;
  double get currentAmount => _currentAmount.value;
  set currentAmount(double value) => _currentAmount.value = value;

  final _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double value) => _progress.value = value;

  final _message = "".obs;
  String get message => _message.value;
  set message(String value) => _message.value = value;

  final _messageColor = Colors.grey.obs;
  MaterialColor get messageColor => _messageColor.value;
  set messageColor(MaterialColor value) => _messageColor.value = value;

  final _targetAmountController = TextEditingController().obs;
  TextEditingController get targetAmountController =>
      _targetAmountController.value;
  set targetAmountController(TextEditingController value) =>
      _targetAmountController.value = value;

  @override
  void onInit() async {
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

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.showSuccess('Successfully refresing...');

      await calculateTotalAmount();

      return true;
    });
  }

  Future<void> setData() async {
    startDate = DateTime(startDate.year, startDate.month, 1);
    endDate = DateTime(endDate.year, endDate.month + 1, 0);

    var targets = await targetRepository.gets() ?? [];
    if (targets.isNotEmpty && targets.first.amount > 0.0) {
      targetAmount = targets.first.amount;
    }

    await calculateTotalAmount();
  }

  Future<void> calculateTotalAmount() async {
    var transactions = await TransactionRepository().gets();
    double totalAmount = 0;

    if (transactions != null) {
      for (var transaction in transactions) {
        if (transaction.date.isAfter(startDate) &&
            transaction.date.isBefore(endDate.add(Duration(days: 1)))) {
          totalAmount += transaction.amount;
        }
      }
    }

    showMessageBaseOnProgress(totalAmount);
  }

  void showMessageBaseOnProgress(double totalAmount) {
    currentAmount = totalAmount;
    progress = (currentAmount / targetAmount);

    if (progress > 1) {
      message = 'You are overspending! 😞';
      messageColor = Colors.red;
    } else if (progress > 0.75) {
      message = 'You are close to overspending! 😬';
      messageColor = Colors.orange;
    } else if (progress > 0.5) {
      message = 'You are on track! 😊';
      messageColor = Colors.yellow;
    } else {
      message = 'You are doing great! 😄';
      messageColor = Colors.green;
    }
  }

  Future<void> onTargetUpdated() async {
    String updatedTarget = "";

    bool isRegistered = await checkIfUserIsRegister();
    if (!isRegistered) {
      await showConfirmDialog();
      return;
    }

    await Future.delayed(Duration(milliseconds: 300));
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text("Update Target Amount".tr, style: AppTextStyles.title),
          content: TextFormField(
            controller: targetAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^(?!0\d)\d*(\.\d{0,2})?$'),
              ),
              LengthLimitingTextInputFormatter(10),
            ],
            onChanged: (value) => updatedTarget = value,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelStyle: AppTextStyles.label,
              hintStyle: AppTextStyles.hint,
              labelText: "Target Amount".tr,
              hintText: "Target Amount".tr,
              prefixIcon: const Icon(Icons.attach_money),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                color: Colors.grey,
                onPressed: () => targetAmountController.clear(),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadius),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel".tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () async {
                Get.back();

                handleUpdateTarget(updatedTarget);
              },
              child: Text("Update".tr, style: AppTextStyles.title),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleSavingTarget() async {
    AppUtils.showLoading();

    var users = await userRepository.gets() ?? [];
    var user = users.first;
    var targets = await targetRepository.gets() ?? [];
    if (targets.isNotEmpty) {
      var value = targets.first;
      var target = TargetModel.create(
        id: value.id,
        amount: targetAmount,
        user: user,
        updatedAt: DateTime.now(),
      );
      await targetRepository.update(target);
    } else {
      var target = TargetModel.create(amount: targetAmount, user: user);
      await targetRepository.save(target);
    }
    await Future.delayed(Duration(seconds: 3));
    AppUtils.hideLoading();
  }

  Future<bool> checkIfUserIsRegister() async {
    var users = await userRepository.gets() ?? [];
    return users.isNotEmpty;
  }

  Future<void> showConfirmDialog() async {
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text('Register'.tr, style: AppTextStyles.title),
          content: Text('Please register first'.tr, style: AppTextStyles.value),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back();
              },
              child: Text('Cancel'.tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed(AppRoutes.register);
              },
              child: Text("Yes".tr, style: AppTextStyles.button),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleUpdateTarget(String updateTarget) async {
    double value = double.tryParse(updateTarget) ?? 0;
    if (value == 0 || targetAmountController.text.isEmpty) {
      AppUtils.showError(
        "Target is with $updateTarget is not allow, please input the valid amount!",
      );
      return;
    }

    targetAmount = double.tryParse(updateTarget) ?? 1;

    await calculateTotalAmount();

    await handleSavingTarget();
  }
}
