import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainController = Get.put(MainController());
  final HomeController homeController = Get.put(HomeController());
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    mainController.setData();

    return Obx(
      () => AppNavigation(
        leading: IconButton(
          onPressed: () => mainController.gotoProfile(),
          icon: CircleAvatar(
            child:
                mainController.isRegistered
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(Get.width),
                      child: Image.memory(
                        base64Decode(mainController.user.profilePicture),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        width: 90,
                        height: 90,
                        frameBuilder: (
                          context,
                          child,
                          frame,
                          wasSynchronouslyLoaded,
                        ) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            opacity: frame == null ? 0.0 : 1.0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person);
                        },
                      ),
                    )
                    : Icon(Icons.person),
          ),
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
                  mainController.onResetTab();
                  homeController.onRefreshing();
                  historyController.onRefreshing();
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
              icon: Icon(FontAwesomeIcons.solidKeyboard),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.moneyBillTransfer),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.usersRectangle),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: RotatedBox(
                quarterTurns: 1,
                child: Icon(FontAwesomeIcons.receipt),
              ),
              label: ''.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.moneyCheckDollar),
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
          type: BottomNavigationBarType.fixed,
          elevation: AppDimensions.elevation,
        ),
      ),
    );
  }
}
