import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class MemberScreen extends StatelessWidget {
  MemberScreen({super.key});

  final MemberController controller = Get.put(MemberController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.gotoCreateMember();
          },
          label: Text("Create Member".tr, style: AppTextStyles.button),
          icon: Icon(FontAwesomeIcons.personCirclePlus),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.onRefreshing(),
          child:
              controller.members.isEmpty
                  ? ListView(
                    children: [
                      SizedBox(height: Get.width * 0.3),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Data".tr, style: AppTextStyles.title),
                          Text(
                            "You can pull to refresh".tr,
                            style: AppTextStyles.subtitle,
                          ),
                        ],
                      ),
                    ],
                  )
                  : ListView.separated(
                    padding: EdgeInsets.only(bottom: Get.width * .15),
                    itemBuilder: (context, index) {
                      UserModel member = controller.members[index];

                      return ListTile(
                        onLongPress: () {
                          controller.onLongPress(index);
                        },
                        onTap: () {
                          controller.onMemberClicked(index);
                        },
                        leading:
                            member.profilePicture.isNotEmpty
                                ? CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  backgroundImage: MemoryImage(
                                    base64Decode(member.profilePicture),
                                  ),
                                )
                                : CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  backgroundImage: CachedNetworkImageProvider(
                                    "https://picsum.photos/200?id=${index + 1}&randoms=true",
                                  ),
                                ),
                        title: Text(member.name, style: AppTextStyles.title),
                        subtitle: Text(
                          member.phone,
                          style: AppTextStyles.subtitle,
                        ),
                        trailing: Text(
                          member.createdAt.format(
                            pattern: AppConstants.dateFormat,
                          ),
                          style: AppTextStyles.label,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: controller.members.length,
                  ),
        ),
      ),
    );
  }
}
