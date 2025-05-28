import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeController extends GetxController {
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
      
      calculateTotalAmount();
      
      return true;
    });
  }

  Future<void> setData() async {
    startDate = DateTime(startDate.year, startDate.month, 1);
    endDate = DateTime(endDate.year, endDate.month + 1, 0);

    await calculateTotalAmount();
  }

  Future<void> calculateTotalAmount() async {
    var transactions = await TransactionRepository().gets();
    double totalAmount = 0;

    if (transactions != null) {
      for (var transaction in transactions) {
        DateTime transactionDate =
            DateTime.tryParse(transaction.date!) ?? DateTime.now();
        if (transactionDate.isAfter(startDate) &&
            transactionDate.isBefore(endDate)) {
          totalAmount += transaction.amount ?? 0;
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
}
