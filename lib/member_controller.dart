import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberController extends GetxController {
  final MemberRepository memberRepository = Get.put(MemberRepository());
  final MemberFirebaseRepository memberFirebaseRepository = Get.put(
    MemberFirebaseRepository(),
  );
  final UserRepository userRepository = Get.put(UserRepository());

  final _members = <MemberModel>[].obs;
  List<MemberModel> get members => _members;
  set members(List<MemberModel> value) => _members.value = value;

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;

  @override
  void onInit() async {
    await setData();
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

  Future<void> setData() async {
    await checkedUser();

    members = await memberFirebaseRepository.reads();
    members =
        members.where((member) {
          return member.user.id == user.id;
        }).toList();
  }

  Future<void> onRefreshing() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Fluttertoast.showToast(msg: "Done refreshing!".tr);

      await setData();
    });
  }

  Future<void> onRemoveMember(int index) async {
    var member = members[index];
    await memberRepository.delete(member.id);
    await setData();
  }

  Future<void> checkedUser() async {
    await userRepository.gets().then((value) {
      if (value != null && value.isNotEmpty) {
        user = value.first;
      }
    });
  }

  Future<void> gotoCreateMember() async {
    await Future.delayed(const Duration(milliseconds: 300));

    Get.toNamed(AppRoutes.createMember)?.then((result) async {
      if (result != null && result) {
        await setData();
      }
    });
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

  Future<void> onMemberClicked(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var member = members[index];
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      context: Get.context!,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            left: AppDimensions.lpadding,
            right: AppDimensions.lpadding,
            bottom: AppDimensions.xxxlpadding,
          ),
          children: [
            member.profilePicture.isNotEmpty
                ? Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Get.width),
                    child: Image.memory(
                      base64Decode(member.profilePicture),
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
                  ),
                )
                : CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary,
                  backgroundImage: CachedNetworkImageProvider(
                    "https://picsum.photos/200?id=${index + 1}&randoms=true",
                  ),
                ),
            SizedBox(height: AppDimensions.padding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("ID".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    member.id,
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spadding),
            Divider(),
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("Name".tr, style: AppTextStyles.label)),
                Expanded(
                  child: Text(
                    member.name,
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spadding),
            Divider(),
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("Phone Number".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  child: Text(
                    member.phone,
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spadding),
            Divider(),
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("Email".tr, style: AppTextStyles.label)),
                Expanded(
                  child: Text(
                    member.email,
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spadding),
            Divider(),
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text("Address".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    member.address,
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spadding),
            Divider(),
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("Created At".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  child: Text(
                    member.createdAt.format(pattern: AppConstants.dateFormat),
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spadding),
            Divider(),
            SizedBox(height: AppDimensions.spadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("Updated At".tr, style: AppTextStyles.label),
                ),
                Expanded(
                  child: Text(
                    member.updatedAt.format(pattern: AppConstants.dateFormat),
                    style: AppTextStyles.value,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
