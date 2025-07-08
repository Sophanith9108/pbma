import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class AppListView extends StatelessWidget {
  const AppListView({
    super.key,
    required this.onFreshing,
    this.onLoadMore,
    this.onItemClick,
    required this.itemCount,
    required this.itemBuilder,
  });

  final Function onFreshing;
  final Function? onLoadMore;
  final Function? onItemClick;
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      elevation: AppDimensions.elevation,
      onRefresh: () => onFreshing(),
      child:
          itemCount == 0
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
              : ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) => itemBuilder(index),
              ),
    );
  }
}
