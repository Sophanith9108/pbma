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
          label: Text("Member".tr, style: AppTextStyles.button),
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
                                      ? CircleAvatar(
                                        radius: 50,
                                        backgroundColor: AppColors.primary,
                                        backgroundImage: FileImage(
                                          File(member.profilePicture),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "ID".tr,
                                          style: AppTextStyles.label,
                                        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Name".tr,
                                          style: AppTextStyles.label,
                                        ),
                                      ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Phone Number".tr,
                                          style: AppTextStyles.label,
                                        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Email".tr,
                                          style: AppTextStyles.label,
                                        ),
                                      ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Address".tr,
                                          style: AppTextStyles.label,
                                        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Created At".tr,
                                          style: AppTextStyles.label,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          member.createdAt.format(
                                            pattern: AppConstants.dateFormat,
                                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Updated At".tr,
                                          style: AppTextStyles.label,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          member.updatedAt.format(
                                            pattern: AppConstants.dateFormat,
                                          ),
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
                        },
                        leading:
                            member.profilePicture.isNotEmpty
                                ? CircleAvatar(
                                  backgroundColor: AppColors.primary,
                                  backgroundImage: FileImage(
                                    File(member.profilePicture),
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
