import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbma/core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double cellHeight = Get.width * .65;
    double blurryRate = 10;
    String bg =
        "https://picsum.photos/${cellHeight.round()}?randoms=${DateTime.now().minute}";

    return Obx(
      () => AppNavigation(
        body: RefreshIndicator(
          onRefresh: () => controller.onRefreshing(),
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              Card.outlined(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(width: 1.5, color: Colors.grey),
                ),
                child: Container(
                  height: cellHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: () => controller.onTargetUpdated(),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadius,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Target".tr, style: AppTextStyles.label),
                              Text(
                                "${controller.targetAmount} ${controller.currency.name}",
                                style: AppTextStyles.amountPositive,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Current".tr, style: AppTextStyles.label),
                            Text(
                              "${controller.currentAmount} ${controller.currency.name}",
                              style: AppTextStyles.amountLeft,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppDimensions.padding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LinearProgressIndicator(
                                value: controller.progress,
                                color: Colors.blue,
                                backgroundColor: Colors.blueGrey.withValues(
                                  alpha: .5,
                                ),
                                minHeight: 50,
                                borderRadius: BorderRadius.circular(Get.width),
                              ),
                              const SizedBox(height: AppDimensions.spadding),
                              Text(
                                controller.message.tr,
                                style: GoogleFonts.battambang(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: controller.messageColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Date".tr, style: AppTextStyles.label),
                            Text(
                              controller.startDate.format(
                                pattern: 'dd.MMM.yyyy',
                              ),
                              style: AppTextStyles.value,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("End Date".tr, style: AppTextStyles.label),
                            Text(
                              controller.endDate.format(pattern: 'dd.MMM.yyyy'),
                              style: AppTextStyles.value,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
