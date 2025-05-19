import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbma/core.dart';

class CreateTransactionController extends MainController {
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

  final _dateToController = TextEditingController().obs;
  TextEditingController get dateToController => _dateToController.value;
  set dateToController(TextEditingController value) =>
      _dateToController.value = value;

  final _timeController = TextEditingController().obs;
  TextEditingController get timeController => _timeController.value;
  set timeController(TextEditingController value) =>
      _timeController.value = value;

  final _timeToController = TextEditingController().obs;
  TextEditingController get timeToController => _timeToController.value;
  set timeToController(TextEditingController value) =>
      _timeToController.value = value;

  final _currencyController = TextEditingController().obs;
  TextEditingController get currencyController => _currencyController.value;
  set currencyController(TextEditingController value) =>
      _currencyController.value = value;

  final _expenseTypeController = TextEditingController().obs;
  TextEditingController get expenseTypeController =>
      _expenseTypeController.value;
  set expenseTypeController(TextEditingController value) =>
      _expenseTypeController.value = value;

  final _paymentMethodController = TextEditingController().obs;
  TextEditingController get paymentMethodController =>
      _paymentMethodController.value;
  set paymentMethodController(TextEditingController value) =>
      _paymentMethodController.value = value;

  final Completer<GoogleMapController> maController =
      Completer<GoogleMapController>();

  final _initialCameraPosition =
      CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 14.4746,
      ).obs;
  CameraPosition get initialCameraPosition => _initialCameraPosition.value;
  set initialCameraPosition(CameraPosition value) =>
      _initialCameraPosition.value = value;

  Future createTransaction() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();

    await showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      Get.back();
      _onClear();
      await Future.delayed(Duration(seconds: 2));
      Get.back(result: true);
    });
  }

  void onMapCreated(GoogleMapController controller) {}

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
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED) {
          _onClear();
        }
      },
    );
  }

  void _onClear() {
    formKey.currentState!.reset();
    dateController.clear();
    timeController.clear();
    isOthersInvolved = false;
  }
}
