import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        leading: IconButton.outlined(
          padding: EdgeInsets.zero,
          onPressed: () => mainController.gotoProfile(),
          icon: CircleAvatar(
            child:
                mainController.user.isLogin &&
                        mainController.user.profilePicture.isNotEmpty
                    ? CircleAvatar(
                      backgroundImage: MemoryImage(
                        base64Decode(mainController.user.profilePicture),
                      ),
                    )
                    : Icon(Icons.person),
          ),
        ),
        title: mainController.title.tr,
        subtitle: mainController.message,
        actions: [
          IconButton(
            onPressed: () {
              mainController.gotoNotifications();
            },
            icon: Badge(child: const Icon(FontAwesomeIcons.bell)),
          ),
          IconButton.outlined(
            onPressed: () {
              mainController.gotoCreateTransaction();
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
