import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateBudgetController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _titleController = TextEditingController().obs;
  TextEditingController get titleController => _titleController.value;
  set titleController(TextEditingController value) =>
      _titleController.value = value;

  final _amountController = TextEditingController().obs;
  TextEditingController get amountController => _amountController.value;
  set amountController(TextEditingController value) =>
      _amountController.value = value;

  final _currencyController = TextEditingController().obs;
  TextEditingController get currencyController => _currencyController.value;
  set currencyController(TextEditingController value) =>
      _currencyController.value = value;

  final _selectedCurrency = CurrencyEnums.USD.obs;
  CurrencyEnums get selectedCurrency => _selectedCurrency.value;
  set selectedCurrency(CurrencyEnums value) => _selectedCurrency.value = value;

  final _purposeController = TextEditingController().obs;
  TextEditingController get purposeController => _purposeController.value;
  set purposeController(TextEditingController value) =>
      _purposeController.value = value;

  final _dateController = TextEditingController().obs;
  TextEditingController get dateController => _dateController.value;
  set dateController(TextEditingController value) =>
      _dateController.value = value;

  final _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;

  Future<void> onCreateBudget() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();

    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      var budget = BudgetModel.create(
        name: titleController.text.trim(),
        amount: double.tryParse(amountController.text.tr) ?? 0.0,
        currency: selectedCurrency,
        purpose: purposeController.text.tr,
        date: selectedDate,
        createdBy: user,
        updatedBy: user,
      );

      await budgetFirebaseRepository.create(budget).then((value) {
        AppUtils.hideLoading();

        _onClear();

        Get.back(result: true);
      });
    });
  }

  Future<void> showDateTime() async {
    await showDateTimePicker(
      handler: (DateTime value) {
        selectedDate = value;
        dateController.text = value.format(pattern: AppConstants.dateFormat);
      },
    );
  }

  Future<void> _onClear() async {
    formKey.currentState!.reset();
    titleController.clear();
    amountController.clear();
    currencyController.clear();
    purposeController.clear();
    dateController.clear();
  }
}
