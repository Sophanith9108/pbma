import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        body: RefreshIndicator(
          onRefresh: () => controller.onRefreshing(),
          child:
              controller.transactions.isEmpty
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
                  : CustomScrollView(
                    slivers:
                        controller.transactions.entries.map((element) {
                          String date = element.key;
                          List<TransactionModel> transactions = element.value;

                          return SliverStickyHeader(
                            header: Container(
                              height: 50,
                              color: AppColors.primary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: AppDimensions.padding),
                                  Text(date, style: AppTextStyles.title),
                                ],
                              ),
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: transactions.length,
                                (context, index) {
                                  TransactionModel transaction =
                                      transactions[index];

                                  return ListTile(
                                    onTap: () async {
                                      await Future.delayed(
                                        const Duration(milliseconds: 300),
                                      );
                                      showModalBottomSheet(
                                        context: Get.context!,
                                        isScrollControlled: true,
                                        useSafeArea: true,
                                        builder: (_) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: AppDimensions.spadding,
                                                  right: AppDimensions.spadding,
                                                  top: AppDimensions.spadding,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        transaction.purpose ??
                                                            "",
                                                        style:
                                                            AppTextStyles
                                                                .header1,
                                                      ),
                                                    ),
                                                    IconButton.outlined(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons.xmark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  padding: const EdgeInsets.all(
                                                    AppDimensions.padding,
                                                  ),
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Reason".tr,
                                                            style:
                                                                AppTextStyles
                                                                    .label,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            transaction
                                                                    .reason ??
                                                                "",
                                                            textAlign:
                                                                TextAlign
                                                                    .justify,
                                                            style:
                                                                AppTextStyles
                                                                    .value,
                                                            strutStyle:
                                                                StrutStyle(
                                                                  height: 1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height:
                                                          AppDimensions.padding,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Amount".tr,
                                                            style:
                                                                AppTextStyles
                                                                    .label,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            transaction.amount!
                                                                .formatCurrency(
                                                                  symbol:
                                                                      transaction
                                                                          .currency!
                                                                          .name,
                                                                ),
                                                            textAlign:
                                                                TextAlign
                                                                    .justify,
                                                            style:
                                                                AppTextStyles
                                                                    .value,
                                                            strutStyle:
                                                                StrutStyle(
                                                                  height: 1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height:
                                                          AppDimensions.padding,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Type".tr,
                                                            style:
                                                                AppTextStyles
                                                                    .label,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            transaction
                                                                .paymentMethod!
                                                                .name,
                                                            textAlign:
                                                                TextAlign
                                                                    .justify,
                                                            style:
                                                                AppTextStyles
                                                                    .value,
                                                            strutStyle:
                                                                StrutStyle(
                                                                  height: 1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height:
                                                          AppDimensions.padding,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                            "Date".tr,
                                                            style:
                                                                AppTextStyles
                                                                    .label,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            "${transaction.date} ${transaction.time}",
                                                            textAlign:
                                                                TextAlign
                                                                    .justify,
                                                            style:
                                                                AppTextStyles
                                                                    .value,
                                                            strutStyle:
                                                                StrutStyle(
                                                                  height: 1.5,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height:
                                                          AppDimensions.padding,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    leading: Icon(FontAwesomeIcons.tractor),
                                    title: Text(
                                      transaction.purpose ?? "",
                                      style: AppTextStyles.title,
                                    ),
                                    subtitle: Text(
                                      transaction.location ?? "",
                                      style: AppTextStyles.subtitle,
                                    ),
                                    trailing: Icon(
                                      FontAwesomeIcons.chevronDown,
                                      size: AppDimensions.miconSize,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }).toList(),
                  ),
        ),
      ),
    );
  }
}
