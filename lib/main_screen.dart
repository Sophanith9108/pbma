import 'package:flutter/material.dart';
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
        title: 'Dashboard'.tr,
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
        ],
        body: controller.children[controller.currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(FontAwesomeIcons.plus),
        ),
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
          onTap: (index) => controller.currentIndex = index,
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
