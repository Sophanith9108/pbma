import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MainController extends GetxController {
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) => _currentIndex.value = index;

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
}
