import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbma/core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double cellHeight = Get.width * .65;
    double itemCellHeight = cellHeight / 1.5;
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
                                "${controller.targetAmount.formatCurrency()}${controller.currency.name}",
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
                              "${controller.currentAmount.formatCurrency()}${controller.currency.name}",
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
                                minHeight: Get.width * .09,
                                borderRadius: BorderRadius.circular(Get.width),
                              ),
                              const SizedBox(height: AppDimensions.spadding),
                              Text(
                                controller.message.tr,
                                style: GoogleFonts.battambang(
                                  fontSize: 18,
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
              const SizedBox(height: AppDimensions.padding),
              Card.outlined(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(width: 1.5, color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.padding),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Remaining Balance".tr,
                          style: AppTextStyles.text,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.remainingBalance.formatCurrency()}${controller.currency.name}",
                          style: AppTextStyles.amountPositive,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              Card(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(
                    width: 1.5,
                    color: const Color.fromARGB(
                      255,
                      208,
                      255,
                      210,
                    ).withValues(alpha: .1),
                  ),
                ),
                child: Container(
                  height: itemCellHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                    gradient:
                        const Color.fromARGB(
                          255,
                          208,
                          255,
                          210,
                        ).leftToRightGradient,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total Income", style: AppTextStyles.text),
                            const SizedBox(height: AppDimensions.padding),
                            Text(
                              controller.targetAmount.formatCurrency(
                                sign: "\$",
                              ),
                              style: AppTextStyles.income,
                            ),
                            const SizedBox(height: AppDimensions.spadding),
                            Text(
                              "This month".tr,
                              style: AppTextStyles.subtitle,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Icon(
                          FontAwesomeIcons.arrowTrendUp,
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              Card(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(
                    width: 1.5,
                    color: const Color.fromARGB(
                      255,
                      255,
                      140,
                      151,
                    ).withValues(alpha: .1),
                  ),
                ),
                child: Container(
                  height: itemCellHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                    gradient:
                        const Color.fromARGB(
                          255,
                          255,
                          140,
                          151,
                        ).lightToDarkGradient,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total Expenses", style: AppTextStyles.text),
                            const SizedBox(height: AppDimensions.padding),
                            Text(
                              controller.currentAmount.formatCurrency(
                                sign: "\$",
                              ),
                              style: AppTextStyles.expense,
                            ),
                            const SizedBox(height: AppDimensions.spadding),
                            Text(
                              "This month".tr,
                              style: AppTextStyles.subtitle,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Icon(
                          FontAwesomeIcons.arrowTrendDown,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              Card(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(
                    width: 1.5,
                    color: const Color.fromARGB(
                      255,
                      177,
                      230,
                      255,
                    ).withValues(alpha: .1),
                  ),
                ),
                child: Container(
                  height: itemCellHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                    gradient:
                        const Color.fromARGB(255, 177, 230, 255).sweepGradient,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Balance", style: AppTextStyles.text),
                            const SizedBox(height: AppDimensions.padding),
                            Text(
                              controller.targetAmount.formatCurrency(
                                sign: "\$",
                              ),
                              style: AppTextStyles.balance,
                            ),
                            const SizedBox(height: AppDimensions.spadding),
                            Text("Available".tr, style: AppTextStyles.subtitle),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Icon(
                          FontAwesomeIcons.googleWallet,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              Card(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(
                    width: 1.5,
                    color: const Color.fromARGB(
                      255,
                      237,
                      230,
                      255,
                    ).withValues(alpha: .1),
                  ),
                ),
                child: Container(
                  height: itemCellHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadius,
                    ),
                    gradient:
                        const Color.fromARGB(255, 210, 192, 255).radialGradient,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Budget Usage", style: AppTextStyles.text),
                            const SizedBox(height: AppDimensions.padding),
                            Text(
                              "${controller.remainingBalancePercent.toStringAsFixed(2)}%",
                              style: AppTextStyles.budget,
                            ),
                            const SizedBox(height: AppDimensions.spadding),
                            Text(
                              "\$${controller.remainingBalance.toStringAsFixed(2)} remaining"
                                  .tr,
                              style: AppTextStyles.subtitle,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Icon(
                          FontAwesomeIcons.circleDot,
                          color: Colors.deepPurple.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
            ],
          ),
        ),
      ),
    );
  }
}
