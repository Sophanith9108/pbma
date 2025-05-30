import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      body: Center(child: Text('This is the Member Screen'.tr)),
    );
  }
}
