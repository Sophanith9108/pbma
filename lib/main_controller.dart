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

  final List<Widget> children = [
    HomeScreen(),
    HistoryScreen(),
    CategoryScreen(),
    SettingScreen(),
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
        title = 'History'.tr;
        break;
      case 2:
        title = 'Category'.tr;
        break;
      case 3:
        title = 'Setting'.tr;
        break;
      default:
        title = 'Home'.tr;
    }
  }
}
