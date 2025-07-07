import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeController extends GetxController {
  final UserRepository userRepository = Get.put(UserRepository());
  final TargetRepository targetRepository = Get.put(TargetRepository());
  final TransactionFirebaseRepository transactionFirebaseRepository = Get.put(
    TransactionFirebaseRepository(),
  );

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

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

  final _remainingBalance = 0.0.obs;
  double get remainingBalance => _remainingBalance.value;
  set remainingBalance(double value) => _remainingBalance.value = value;

  final _remainingBalancePercent = 0.0.obs;
  double get remainingBalancePercent => _remainingBalancePercent.value;
  set remainingBalancePercent(double value) =>
      _remainingBalancePercent.value = value;

  final _currentAmount = 0.0.obs;
  double get currentAmount => _currentAmount.value;
  set currentAmount(double value) => _currentAmount.value = value;

  final _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double value) => _progress.value = value;

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

  Future<void> checkedUser() async {
    await userRepository.gets().then((value) {
      if (value != null && value.isNotEmpty) {
        user = value.first;
      }
    });
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      await setData();

      return true;
    });
  }

  Future<void> setData() async {
    await checkedUser();

    startDate = DateTime(startDate.year, startDate.month, 1);
    endDate = DateTime(endDate.year, endDate.month + 1, 0);

    await calculateTotalAmount();
  }

  Future<void> calculateTotalAmount() async {
    List<TransactionModel> transactions =
        await transactionFirebaseRepository.reads();
    transactions.where((element) {
      return element.createdBy.id == user.id;
    });

    currentAmount = 0.0;

    for (var transaction in transactions) {
      if (transaction.date.isAfter(startDate.add(Duration(days: -1))) &&
          transaction.date.isBefore(endDate.add(Duration(days: 1)))) {
        currentAmount += transaction.amount;
      }
    }

    await showMessageBaseOnProgress();

    await calculateRemainBalance();
  }

  Future<void> calculateRemainBalance() async {
    remainingBalance = targetAmount - currentAmount;
    remainingBalancePercent = (remainingBalance / targetAmount) * 100;
  }

  Future<void> showMessageBaseOnProgress() async {
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
    await Future.delayed(Duration(milliseconds: 300));

    await userRepository.gets().then((value) {
      if (value == null || value.isEmpty || !value.first.isLogin) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }
    });
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

  Future<void> gotoTransactions() async {}

  Future<void> onTransactionClick(int index) async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }
}
