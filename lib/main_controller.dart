import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MainController extends GetxController {
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) => _currentIndex.value = index;

  final _title = 'Home'.obs;
  String get title => _title.value;
  set title(String title) => _title.value = title;

  final _data = dynamic.obs;
  dynamic get data => _data.value;
  set data(dynamic data) => _data.value = data;

  final List<Widget> children = [
    HomeScreen(),
    HistoryScreen(),
    CategoryScreen(),
    SettingScreen(),
    AccountScreen(),
  ];

  @override
  void onInit() {
    _initialized();
    super.onInit();
  }

  void _initialized() {}

  Future onTabSelected(int index) async {
    currentIndex = index;
    switch (index) {
      case 0:
        title = 'Home'.tr;
        break;
      case 1:
        title = 'Transactions'.tr;
        break;
      case 2:
        title = 'Subs'.tr;
        break;
      case 3:
        title = 'Budgets'.tr;
        break;
      case 4:
        title = 'Accounts'.tr;
        break;
      default:
        title = 'Home'.tr;
    }
  }

  void setData(dynamic data) {
    this.data = data;
  }
}
