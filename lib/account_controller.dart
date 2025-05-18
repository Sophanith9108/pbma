import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class AccountController extends GetxController {
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

  @override
  void onInit() {
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

  Future<void> setData() async {
    banks = [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 300));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.red.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Text(
                    "Bank of America Bank".toUpperCase(),
                    style: AppTextStyles.header1,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
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
                        1000000.formatCurrency(symbol: 'USD'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.value,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccApplePay),
                ),
              ],
            ),
          ),
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 300));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.green.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Text(
                    "JPMorgan Chase Bank".toUpperCase(),
                    style: AppTextStyles.header1,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
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
                        2000000.formatCurrency(symbol: 'USD'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.value,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccMastercard),
                ),
              ],
            ),
          ),
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 300));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.blue.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Text(
                    "Heng Feng (Cambodia) Bank".toUpperCase(),
                    style: AppTextStyles.header1,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
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
                        3000000.formatCurrency(symbol: 'USD'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.value,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccVisa),
                ),
              ],
            ),
          ),
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 300));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.purple.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Text(
                    "ABA Bank".toUpperCase(),
                    style: AppTextStyles.header1,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
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
                        4000000.formatCurrency(symbol: 'USD'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.value,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccVisa),
                ),
              ],
            ),
          ),
        ),
      ),
    ];

    creditCards = [
      Card(
        elevation: AppDimensions.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 250));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.red.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amex Card".toUpperCase(),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Credit Card".toUpperCase(),
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
                    },
                    icon: Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 18,
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
                      Text("Due".tr, style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Text(
                        500.formatCurrency(sign: '\$'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccAmex),
                ),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: AppDimensions.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 250));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.lightGreen.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discover".toUpperCase(),
                        style: AppTextStyles.title,
                      ),
                      Text(
                        "Credit Card".toUpperCase(),
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
                    },
                    icon: Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 18,
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
                      Text("Due".tr, style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Text(
                        500.formatCurrency(sign: '\$'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccDiscover),
                ),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: AppDimensions.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 250));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.lightBlue.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PayPay Card".toUpperCase(),
                        style: AppTextStyles.title,
                      ),
                      Text(
                        "Credit Card".toUpperCase(),
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
                    },
                    icon: Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 18,
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
                      Text("Due".tr, style: AppTextStyles.caption),
                      const SizedBox(height: 4),
                      Text(
                        500.formatCurrency(sign: '\$'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccPaypal),
                ),
              ],
            ),
          ),
        ),
      ),
      Card(
        elevation: AppDimensions.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          side: BorderSide(
            width: 1.5,
            color: Colors.grey.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await Future.delayed(Duration(milliseconds: 250));
            Get.toNamed(AppRoutes.detailTransaction);
          },
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          child: Container(
            decoration: BoxDecoration(
              gradient: Colors.deepPurple.sweepGradient,
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stripe Card".toUpperCase(),
                        style: AppTextStyles.title,
                      ),
                      Text(
                        "Credit Card".toUpperCase(),
                        style: AppTextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 300));
                      _handleSettingOptions();
                    },
                    icon: Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 18,
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
                      Text(
                        "Previous Due".toUpperCase(),
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        500.formatCurrency(sign: '\$'),
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateTime.now().format(pattern: "dd.MMM.yyy"),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.ccStripe),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  void _handleSettingOptions() {
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
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              ListTile(
                leading: Icon(FontAwesomeIcons.pen, color: Colors.blue),
                title: Text('Edit'.tr),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 300));
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.trash, color: Colors.red),
                title: Text('Delete'.tr),
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 300));
                  Get.back();
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
    selectedPage = value!.toInt();
  }
}
