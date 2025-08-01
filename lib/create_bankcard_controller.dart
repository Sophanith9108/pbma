import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:flutter/services.dart' show rootBundle;

class CreateBankCardController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _bankNameController = TextEditingController().obs;
  TextEditingController get bankNameController => _bankNameController.value;
  set bankNameController(TextEditingController value) =>
      _bankNameController.value = value;

  final _cardTypeController = TextEditingController().obs;
  TextEditingController get cardTypeController => _cardTypeController.value;
  set cardTypeController(TextEditingController value) =>
      _cardTypeController.value = value;

  final _selectedCardType = BankCardEnum.debit.obs;
  BankCardEnum get selectedCardType => _selectedCardType.value;
  set selectedCardType(BankCardEnum value) => _selectedCardType.value = value;

  final _paymentNetworkController = TextEditingController().obs;
  TextEditingController get paymentNetworkController =>
      _paymentNetworkController.value;
  set paymentNetworkController(TextEditingController value) =>
      _paymentNetworkController.value = value;

  final _selectedPaymentNetwork = PaymentNetworkEnum.visa.obs;
  PaymentNetworkEnum get selectedPaymentNetwork =>
      _selectedPaymentNetwork.value;
  set selectedPaymentNetwork(PaymentNetworkEnum value) =>
      _selectedPaymentNetwork.value = value;

  final _cardBalanceController = TextEditingController().obs;
  TextEditingController get cardBalanceController =>
      _cardBalanceController.value;
  set cardBalanceController(TextEditingController value) =>
      _cardBalanceController.value = value;

  final _selectedCurrency = CurrencyEnums.USD.obs;
  CurrencyEnums get selectedCurrency => _selectedCurrency.value;
  set selectedCurrency(CurrencyEnums value) => _selectedCurrency.value = value;

  final _cardCurrencyController = TextEditingController().obs;
  TextEditingController get cardCurrencyController =>
      _cardCurrencyController.value;
  set cardCurrencyController(TextEditingController value) =>
      _cardCurrencyController.value = value;

  final _banks = <BankModel>[].obs;
  List<BankModel> get banks => _banks;
  set banks(List<BankModel> value) => _banks.value = value;

  @override
  void onInit() async {
    await onRetrievedBankList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _onClear();
    super.onClose();
  }

  Future<void> onAddBankCard() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();

    final bankCard = BankCardModel.create(
      bankName: bankNameController.text.trim(),
      cardType: selectedCardType,
      paymentNetwork: selectedPaymentNetwork,
      balance: double.tryParse(cardBalanceController.text.trim()) ?? 0.0,
      currency: selectedCurrency,
      user: user,
    );

    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3));
    await bankCardFirebaseRepository.create(bankCard).then((value) async {
      AppUtils.hideLoading();

      await accountController.retrieveBankCards();

      Get.back(result: true);
      _onClear();
    });
  }

  void _onClear() {
    formKey.currentState!.reset();
    bankNameController.clear();
    cardBalanceController.clear();
    cardCurrencyController.clear();
    cardTypeController.clear();
    paymentNetworkController.clear();
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
              banks.map((bank) {
                return ListTile(
                  leading: CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: bank.logo,
                      width: 40,
                      height: 40,
                      placeholder: (context, url) {
                        return Center(child: const CircularProgressIndicator());
                      },
                      errorWidget: (context, url, error) {
                        return Icon(FontAwesomeIcons.buildingColumns, size: 18);
                      },
                    ),
                  ),
                  title: Text(bank.name.tr, style: AppTextStyles.title),
                  subtitle: Text(
                    bank.headquarters,
                    style: AppTextStyles.subtitle,
                  ),
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

  Future<void> onRetrievedBankList() async {
    try {
      final String jsonString = await rootBundle.loadString(AppAssets.banklist);
      final List<dynamic> jsonArray = jsonDecode(jsonString);
      banks = jsonArray.map((item) => BankModel.fromJson(json: item)).toList();
    } catch (e, stack) {
      debugPrint('Failed to load bank list: $e\n$stack');
      banks = [];
    }
  }

  Future<void> onCurrencySelected() async {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              CurrencyEnums.values.map((currency) {
                return ListTile(
                  leading: Icon(currency.icon, size: 18),
                  title: Text(currency.name.tr, style: AppTextStyles.title),
                  subtitle: Text(
                    currency.description.tr,
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    selectedCurrency = currency;
                    cardCurrencyController.text = currency.name;
                    Get.back();
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onCardTypeSelected() async {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              BankCardEnum.values.map((cardType) {
                return ListTile(
                  leading: Icon(cardType.icon, size: 18),
                  title: Text(cardType.name.tr, style: AppTextStyles.title),
                  subtitle: Text(
                    cardType.description.tr,
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    selectedCardType = cardType;
                    cardTypeController.text = cardType.name;
                    Get.back();
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onCardBrandSelected() async {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              PaymentNetworkEnum.values.map((network) {
                return ListTile(
                  leading: Icon(network.icon, size: 18),
                  title: Text(network.name.tr, style: AppTextStyles.title),
                  subtitle: Text(
                    network.description.tr,
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    selectedPaymentNetwork = network;
                    paymentNetworkController.text = network.name;
                    Get.back();
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
