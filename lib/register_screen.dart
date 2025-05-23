import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      title: 'Register'.tr,
      body: Center(child: Text('Register Screen')),
    );
  }
}
