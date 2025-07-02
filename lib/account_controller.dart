import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbma/core.dart';

class AccountController extends GetxController {
  final BankCardFirebaseRepository bankCardFirebaseRepository = Get.put(
    BankCardFirebaseRepository(),
  );
  final UserFirebaseRepository userFirebaseRepository = Get.put(
    UserFirebaseRepository(),
  );
  final TransactionFirebaseRepository transactionFirebaseRepository = Get.put(
    TransactionFirebaseRepository(),
  );
  final UserRepository userRepository = Get.put(UserRepository());

  final _banks = <Widget>[].obs;
  List<Widget> get banks => _banks;
  set banks(List<Widget> value) => _banks.value = value;

  final _creditCards = <Widget>[].obs;
  List<Widget> get creditCards => _creditCards;
  set creditCards(List<Widget> value) => _creditCards.value = value;

  final _carouselController = CarouselSliderController().obs;
  CarouselSliderController get carouselController => _carouselController.value;
  set carouselController(CarouselSliderController value) =>
      _carouselController.value = value;

  final _selectedPage = 0.obs;
  int get selectedPage => _selectedPage.value;
  set selectedPage(int value) => _selectedPage.value = value;

  final _transactions = <TransactionModel>[].obs;
  List<TransactionModel> get transactions => _transactions;
  set transactions(List<TransactionModel> value) => _transactions.value = value;

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

  Future<void> setData() async {
    await _retrieveBankCards();
    await _retrieveTransactions();
  }

  Future<void> _retrieveBankCards() async {
    await bankCardFirebaseRepository.reads().then((value) {
      value.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });
      banks =
          value.map((bank) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                side: BorderSide(
                  width: 1.5,
                  color: Colors.grey.withValues(alpha: .5),
                ),
              ),
              child: InkWell(
                onTap: () async {
                  await gotoBankCardDetail();
                },
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppUtils.randomColor().sweepGradient,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 10,
                        right: 10,
                        bottom: 10,
                        child: Text(
                          bank.bankName.toUpperCase(),
                          style: AppTextStyles.header1,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () async {
                            await Future.delayed(Duration(milliseconds: 300));
                            _handleSettingOptions(bankCard: bank);
                          },
                          icon: Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Balance".tr, style: AppTextStyles.label),
                            const SizedBox(height: 4),
                            Text(
                              bank.balance.formatCurrency(
                                symbol: bank.currency.name,
                              ),
                              style: AppTextStyles.title,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              bank.createdAt.format(pattern: "dd.MMM.yyy"),
                              style: AppTextStyles.value,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Icon(bank.paymentNetwork.icon),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList();
    });
  }

  Future<void> gotoTransactionDetail(int index) async {
    await Future.delayed(Duration(milliseconds: 300));
    var transaction = transactions[index];

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      useRootNavigator: true,
      enableDrag: true,
      elevation: AppDimensions.elevation,
      useSafeArea: true,
      context: Get.context!,
      builder: (_) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimensions.spadding),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Detail Transaction'.tr,
                      style: AppTextStyles.title,
                    ),
                  ),
                  IconButton.outlined(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("ID".tr, style: AppTextStyles.label),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.id,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Transaction".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.createdAt.format(pattern: "dd.MMM.yyy"),
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text("Amount".tr, style: AppTextStyles.label),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.amount.formatCurrency(
                              symbol: transaction.currency.name,
                            ),
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Created At".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${transaction.date.format(pattern: AppConstants.dateFormat)} ${transaction.time}",
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Created By".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.createdBy.name,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Purpose".tr, style: AppTextStyles.label),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.purpose,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Bank".tr, style: AppTextStyles.label),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.bankCard.bankName,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Spent On".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.expenseType.name,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Payment Method".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.paymentMethod.name,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Transaction Type".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.transactionType.name,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Status".tr, style: AppTextStyles.label),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.status.name,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Location".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.location,
                            style: AppTextStyles.title,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: Get.width * .55,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: false,
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(
                    zoom: AppConstants.zoomLevel,
                    target: LatLng(transaction.latitude, transaction.longitude),
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(transaction.id),
                      position: LatLng(
                        transaction.latitude,
                        transaction.longitude,
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      ),
                    ),
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleSettingOptions({required BankCardModel bankCard}) {
    showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: true,
      elevation: AppDimensions.elevation,
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(FontAwesomeIcons.pen, color: Colors.blue),
                title: Text('Edit'.tr, style: AppTextStyles.title),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 300));
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.trash, color: Colors.red),
                title: Text('Delete'.tr, style: AppTextStyles.title),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 300));
                  Get.back();

                  _showDeleteConfirmation(bankCard: bankCard);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    selectedPage = index;
  }

  void onDotClicked(int index) {
    selectedPage = index;
    carouselController.animateToPage(index);
  }

  void onPageScrolled(double? value) {
    selectedPage = value?.toInt() ?? 0;
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      await setData();
      return true;
    });
  }

  Future<void> gotoBankCard() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await userRepository.gets().then((value) {
      if (value == null || value.isEmpty || !value.first.isLogin) {
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      Get.toNamed(AppRoutes.createBankCard)?.then((value) async {
        if (value != null && value) {
          await setData();
          if (banks.isNotEmpty && selectedPage > 1) {
            selectedPage = 0;
            carouselController.animateToPage(selectedPage);
          }
        }
      });
    });
  }

  Future<void> _showDeleteConfirmation({
    required BankCardModel bankCard,
  }) async {
    await Get.dialog(
      AlertDialog(
        title: Text('Delete Confirmation'.tr, style: AppTextStyles.header1),
        content: Text.rich(
          TextSpan(
            text: 'Are you sure you want to delete'.tr,
            style: AppTextStyles.value,
            children: [
              TextSpan(text: " "),
              TextSpan(
                text: bankCard.bankName.toUpperCase(),
                style: AppTextStyles.value.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: "?"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'.tr, style: AppTextStyles.button),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _handleDeleteBankCard(bankCard: bankCard);
            },
            child: Text('Delete'.tr, style: AppTextStyles.button),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDeleteBankCard({required BankCardModel bankCard}) async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      await bankCardFirebaseRepository.delete(bankCard.id);

      await setData();

      AppUtils.hideLoading();
    });
  }

  Future<void> _retrieveTransactions() async {
    await transactionFirebaseRepository.reads().then((value) {
      value.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });
      transactions = value;
    });
  }

  Future<void> gotoBankCardDetail() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
