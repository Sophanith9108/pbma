import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbma/core.dart';

class CreateTransactionController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _purposeController = TextEditingController().obs;
  TextEditingController get purposeController => _purposeController.value;
  set purposeController(TextEditingController value) =>
      _purposeController.value = value;

  final _amountController = TextEditingController().obs;
  TextEditingController get amountController => _amountController.value;
  set amountController(TextEditingController value) =>
      _amountController.value = value;

  final _currencyController = TextEditingController().obs;
  TextEditingController get currencyController => _currencyController.value;
  set currencyController(TextEditingController value) =>
      _currencyController.value = value;

  final _expenseTypeController = TextEditingController().obs;
  TextEditingController get expenseTypeController =>
      _expenseTypeController.value;
  set expenseTypeController(TextEditingController value) =>
      _expenseTypeController.value = value;

  final _reasonController = TextEditingController().obs;
  TextEditingController get reasonController => _reasonController.value;
  set reasonController(TextEditingController value) =>
      _reasonController.value = value;

  final _paymentMethodController = TextEditingController().obs;
  TextEditingController get paymentMethodController =>
      _paymentMethodController.value;
  set paymentMethodController(TextEditingController value) =>
      _paymentMethodController.value = value;

  final _isOthersInvolved = false.obs;
  bool get isOthersInvolved => _isOthersInvolved.value;
  set isOthersInvolved(bool value) => _isOthersInvolved.value = value;

  final _dateController = TextEditingController().obs;
  TextEditingController get dateController => _dateController.value;
  set dateController(TextEditingController value) =>
      _dateController.value = value;

  final _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;

  final _timeController = TextEditingController().obs;
  TextEditingController get timeController => _timeController.value;
  set timeController(TextEditingController value) =>
      _timeController.value = value;

  final _locationController = TextEditingController().obs;
  TextEditingController get locationController => _locationController.value;
  set locationController(TextEditingController value) =>
      _locationController.value = value;

  final _othersInvolvedController = TextEditingController().obs;
  TextEditingController get othersInvolvedController =>
      _othersInvolvedController.value;
  set othersInvolvedController(TextEditingController value) =>
      _othersInvolvedController.value = value;

  final _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 12).obs;
  CameraPosition get initialCameraPosition => _initialCameraPosition.value;
  set initialCameraPosition(CameraPosition value) =>
      _initialCameraPosition.value = value;

  final _address = ''.obs;
  String get address => _address.value;
  set address(String value) => _address.value = value;

  final _selectedGender = GenderEnums.values.first.obs;
  GenderEnums get selectedGender => _selectedGender.value;
  set selectedGender(GenderEnums value) => _selectedGender.value = value;

  final _selectedCurrency = CurrencyEnums.values.first.obs;
  CurrencyEnums get selectedCurrency => _selectedCurrency.value;
  set selectedCurrency(CurrencyEnums value) => _selectedCurrency.value = value;

  final _selectedExpenseType = ExpenseTypeEnums.values.first.obs;
  ExpenseTypeEnums get selectedExpenseType => _selectedExpenseType.value;
  set selectedExpenseType(ExpenseTypeEnums value) =>
      _selectedExpenseType.value = value;

  final _selectedPaymentMethod = PaymentMethodEnums.values.first.obs;
  PaymentMethodEnums get selectedPaymentMethod => _selectedPaymentMethod.value;
  set selectedPaymentMethod(PaymentMethodEnums value) =>
      _selectedPaymentMethod.value = value;

  final _bankCardController = TextEditingController().obs;
  TextEditingController get bankCardController => _bankCardController.value;
  set bankCardController(TextEditingController value) =>
      _bankCardController.value = value;

  final _selectedBankCard = BankCardModel().obs;
  BankCardModel get selectedBankCard => _selectedBankCard.value;
  set selectedBankCard(BankCardModel value) => _selectedBankCard.value = value;

  final _bankCards = <BankCardModel>[].obs;
  List<BankCardModel> get bankCards => _bankCards;
  set bankCards(List<BankCardModel> value) => _bankCards.value = value;

  late GoogleMapController mapController;

  static const double zoomLevel = 12;

  @override
  void onInit() async {
    await _setData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future onCreateTransaction() async {
    var currentUsers = await userRepository.gets() ?? [];

    if (currentUsers.isEmpty) {
      Fluttertoast.showToast(msg: 'Please register first'.tr);
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.register);
      return;
    }

    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();

    var createdBy = currentUsers.first;

    var transaction = TransactionModel.create(
      purpose: purposeController.text.trim(),
      amount: double.tryParse(amountController.text) ?? 0.0,
      currency: selectedCurrency,
      expenseType: selectedExpenseType,
      reason: reasonController.text.trim(),
      paymentMethod: selectedPaymentMethod,
      bankCard: selectedBankCard,
      isOthersInvolved: isOthersInvolved,
      date: selectedDate,
      time: timeController.text,
      location: address.trim(),
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
      othersInvolved: isOthersInvolved ? [] : [],
      createdBy: createdBy,
      updatedBy: createdBy,
      updatedAt: DateTime.now(),
      status: TransactionStatusEnums.success,
      transactionType: TransactionTypeEnums.expense,
    );

    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      await transactionRepository.save(transaction);
      await transactionFirebaseRepository.create(transaction);
      AppUtils.hideLoading();

      _onClear();
      Get.back(result: true);
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();
      mapController = controller;

      await getCurrentLocation().then((value) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: zoomLevel,
            ),
          ),
        );
        currentLocation = LatLng(value.latitude, value.longitude);
        getAddressFromLatLong(
          value.latitude,
          value.longitude,
        ).then((value) => address = value);
      });
    });
  }

  void _onClear() {
    formKey.currentState!.reset();
    purposeController.clear();
    amountController.clear();
    currencyController.clear();
    expenseTypeController.clear();
    reasonController.clear();
    paymentMethodController.clear();
    dateController.clear();
    timeController.clear();
    locationController.clear();
    othersInvolvedController.clear();
    isOthersInvolved = false;
  }

  void onDropLocation() {
    locationController.text = address;
  }

  Future<void> onAddressSelected() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showMapSelectAddress((value) {
      address = value;
      locationController.text = value;
    });
  }

  Future<void> _setData() async {
    await bankCardFirebaseRepository.reads().then((value) {
      bankCards = value;
    });
  }

  Future<void> gotoCreateBankCard() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Get.toNamed(AppRoutes.createBankCard)?.then((value) async {
      if (value != null && value) {
        await _setData();
      }
    });
  }
}
