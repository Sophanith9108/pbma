import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.userAstronaut),
        ),
        title: controller.title.tr,
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
                Fluttertoast.showToast(
                  msg: "The result has been received: $value",
                );
              });
            },
            icon: const Icon(FontAwesomeIcons.plus),
          ),
        ],
        body: controller.children[controller.currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseChimney),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.businessTime),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calculator),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gear),
              label: '',
            ),
          ],
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.onTabSelected(index),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: AppDimensions.elevation,
        ),
      ),
    );
  }
}
