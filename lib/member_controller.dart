import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberController extends GetxController {
  final MemberRepository _memberRepository = Get.put(MemberRepository());

  final _members = <UserModel>[].obs;
  List<UserModel> get members => _members;
  set members(List<UserModel> value) => _members.value = value;

  Future<void> onRefreshing() async {
    Get.back();
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();

      AppUtils.showSuccess('Successfully refresing...');

      setData();
    });
  }

  Future<void> onRemoveMember(int index) async {
    var member = members[index];
    await _memberRepository.delete(member.id);
    onRefreshing();
  }

  Future<void> gotoCreateMember() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      Get.toNamed(AppRoutes.createMember)?.then((value) {
        if (value != null && value) {
          onRefreshing();
        }
      });
    });
  }

  Future<void> setData() async {
    members = await _memberRepository.gets() ?? [];
    if (members.isEmpty) {
      members = UserModel.mockup();
      return;
    }
    members = members.reversed.toList();
  }

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onLongPress(int index) async {
    var member = members[index];
    showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          title: Text('Remove Member'.tr, style: AppTextStyles.label),
          content: Text.rich(
            TextSpan(
              text: 'Are you sure you want to remove '.tr,
              style: AppTextStyles.value,
              children: [
                TextSpan(text: member.name, style: AppTextStyles.header1),
                TextSpan(text: '?', style: AppTextStyles.label),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'.tr, style: AppTextStyles.button),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                await onRemoveMember(index);
              },
              child: Text('Delete'.tr, style: AppTextStyles.button),
            ),
          ],
        );
      },
    );
  }
}
