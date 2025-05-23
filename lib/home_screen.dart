import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                              delegate: SliverChildBuilderDelegate(childCount: transactions.length, (
                                context,
                                index,
                              ) {
                                TransactionModel transaction =
                                    transactions[index];

                                return ListTile(
                                  onLongPress:
                                      () => controller.onDeleteTransaction(
                                        transaction,
                                      ),
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
                                                left: AppDimensions.mpadding,
                                                right: AppDimensions.mpadding,
                                                top: AppDimensions.mpadding,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      transaction.purpose ?? "",
                                                      style:
                                                          AppTextStyles.header1,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          transaction.reason ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Created By".tr,
                                                          style:
                                                              AppTextStyles
                                                                  .label,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          transaction
                                                                  .createdBy
                                                                  ?.name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Pay For".tr,
                                                          style:
                                                              AppTextStyles
                                                                  .label,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          transaction
                                                                  .expenseType
                                                                  ?.name ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "Located At".tr,
                                                          style:
                                                              AppTextStyles
                                                                  .label,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          transaction
                                                                  .location ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "With Who?".tr,
                                                          style:
                                                              AppTextStyles
                                                                  .label,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          transaction
                                                                  .isOthersInvolved!
                                                              ? transaction
                                                                      .othersInvolved ??
                                                                  ""
                                                              : "No one getting involved, try again later!"
                                                                  .tr,
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                          "ID".tr,
                                                          style:
                                                              AppTextStyles
                                                                  .label,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          transaction.id ?? "",
                                                          textAlign:
                                                              TextAlign.justify,
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
                                                  Container(
                                                    height: Get.width * 0.75,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            AppDimensions
                                                                .borderRadius,
                                                          ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            AppDimensions
                                                                .borderRadius,
                                                          ),
                                                      child: GoogleMap(
                                                        mapType: MapType.hybrid,
                                                        myLocationEnabled:
                                                            false,
                                                        myLocationButtonEnabled:
                                                            false,
                                                        zoomControlsEnabled:
                                                            false,
                                                        mapToolbarEnabled:
                                                            false,
                                                        zoomGesturesEnabled:
                                                            false,
                                                        markers: {
                                                          Marker(
                                                            markerId: MarkerId(
                                                              transaction.id ??
                                                                  "",
                                                            ),
                                                            position: LatLng(
                                                              transaction
                                                                  .latitude,
                                                              transaction
                                                                  .longitude,
                                                            ),
                                                            infoWindow: InfoWindow(
                                                              title:
                                                                  transaction
                                                                      .location ??
                                                                  "",
                                                              snippet:
                                                                  transaction
                                                                      .purpose ??
                                                                  "",
                                                            ),
                                                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                                              BitmapDescriptor
                                                                  .hueBlue,
                                                            ),
                                                          ),
                                                        },
                                                        initialCameraPosition:
                                                            CameraPosition(
                                                              zoom: 12,
                                                              target: LatLng(
                                                                transaction
                                                                    .latitude,
                                                                transaction
                                                                    .longitude,
                                                              ),
                                                            ),
                                                      ),
                                                    ),
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
                                  leading: Icon(
                                    FontAwesomeIcons.tentArrowLeftRight,
                                  ),
                                  title: Text(
                                    transaction.purpose ?? "",
                                    style: AppTextStyles.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    transaction.location ?? "",
                                    style: AppTextStyles.subtitle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Icon(
                                    FontAwesomeIcons.circleChevronDown,
                                    size: AppDimensions.miconSize,
                                  ),
                                );
                              }),
                            ),
                          );
                        }).toList(),
                  ),
        ),
      ),
    );
  }
}
