import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainController = Get.put(MainController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        leading: IconButton(
          onPressed: () => mainController.gotoProfile(),
          icon: Icon(FontAwesomeIcons.userAstronaut),
        ),
        title: mainController.title.tr,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.notifications);
            },
            icon: const Icon(FontAwesomeIcons.bell),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.transaction)?.then((value) {
                mainController.onResetTab();
                homeController.onRefreshing();
              });
            },
            icon: const Icon(FontAwesomeIcons.plus),
          ),
        ],
        body: mainController.children[mainController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseCircleCheck),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.clockRotateLeft),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.personCircleCheck),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.personRays),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.wallet),
              label: ''.tr,
            ),
          ],
          currentIndex: mainController.currentIndex,
          onTap: (index) => mainController.onTabSelected(index),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          elevation: AppDimensions.elevation,
        ),
      ),
    );
  }
}
