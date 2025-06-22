import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateBankCardController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _bankNameController = TextEditingController().obs;
  TextEditingController get bankNameController => _bankNameController.value;
  set bankNameController(TextEditingController value) =>
      _bankNameController.value = value;

  Future<void> onAddBankCard() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();
    Get.back(result: true);
    _onClear();
  }

  void _onClear() {
    formKey.currentState!.reset();
    bankNameController.clear();
  }

  Future<void> onBankSelected() async {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              BankCardEnum.values.map((bank) {
                return ListTile(
                  leading: Icon(bank.icon),
                  title: Text(bank.name.tr, style: AppTextStyles.title),
                  subtitle: Text(
                    bank.description.tr,
                    style: AppTextStyles.subtitle,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    bankNameController.text = bank.name.tr;
                    Get.back();
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
