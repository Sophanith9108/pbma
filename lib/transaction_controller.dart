import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class TransactionController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _isOthersInvolved = false.obs;
  bool get isOthersInvolved => _isOthersInvolved.value;
  set isOthersInvolved(bool value) => _isOthersInvolved.value = value;

  final _dateController = TextEditingController().obs;
  TextEditingController get dateController => _dateController.value;
  set dateController(TextEditingController value) =>
      _dateController.value = value;

  final _timeController = TextEditingController().obs;
  TextEditingController get timeController => _timeController.value;
  set timeController(TextEditingController value) =>
      _timeController.value = value;

  Future createTransaction() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();
    await Future.delayed(const Duration(milliseconds: 300));
    await showLoading();
    await Future.delayed(const Duration(seconds: 3));
    Get.back();
    await showSuccessMessage();
    await Future.delayed(const Duration(seconds: 1));
    _onClear();
    await Future.delayed(const Duration(seconds: 3));
    Get.back(result: true);
  }

  Future<void> showLoading() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) {
        return Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<void> showSuccessMessage() async {
    Get.snackbar(
      'Transaction has been created'.tr,
      'You have been spent the money!',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
    );
  }

  void _onClear() {
    formKey.currentState!.reset();
    dateController.clear();
    timeController.clear();
    isOthersInvolved = false;
  }
}
