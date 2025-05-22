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
          onPressed: () {},
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
                if (value != null && value) {
                  homeController.setData();
                }
              });
            },
            icon: const Icon(FontAwesomeIcons.plus),
          ),
        ],
        body: mainController.children[mainController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseChimney),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.businessTime),
              label: 'Transactions'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidClock),
              label: 'Subs',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calculator),
              label: 'Budgets',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.wallet),
              label: 'Accounts'.tr,
            ),
          ],
          currentIndex: mainController.currentIndex,
          onTap: (index) => mainController.onTabSelected(index),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          elevation: AppDimensions.elevation,
        ),
      ),
    );
  }
}
