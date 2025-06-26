import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.gotoBankCard();
          },
          label: Text("Link Account".tr, style: AppTextStyles.button),
          icon: const Icon(FontAwesomeIcons.link),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.onRefreshing(),
          child: ListView(
            padding: EdgeInsets.only(
              left: AppDimensions.padding,
              right: AppDimensions.padding,
              top: AppDimensions.padding,
              bottom: Get.width * .2,
            ),
            children: [
              Text("Banks".tr, style: AppTextStyles.header1),
              const SizedBox(height: 8),
              controller.banks.isEmpty
                  ? Card(
                    elevation: AppDimensions.elevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius,
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius,
                      ),
                      onTap: () => controller.gotoBankCard(),
                      child: SizedBox(
                        height: Get.width * .5,
                        child: Center(
                          child: Text(
                            "Add your bank accounts".tr,
                            style: AppTextStyles.label,
                          ),
                        ),
                      ),
                    ),
                  )
                  : CarouselSlider(
                    items: controller.banks,
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                      height: Get.width * .5,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: controller.selectedPage,
                      enableInfiniteScroll: false,
                      onPageChanged:
                          (index, reason) =>
                              controller.onPageChanged(index, reason),
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onScrolled: (value) {
                        controller.onPageScrolled(value);
                      },
                    ),
                  ),
              const SizedBox(height: 8),
              Visibility(
                visible: controller.banks.isNotEmpty,
                child: Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: controller.selectedPage,
                    count: controller.banks.length,
                    onDotClicked: (index) => controller.onDotClicked(index),
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.primary,
                      dotColor: Colors.grey.withValues(alpha: .5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              Text("Transactions".tr, style: AppTextStyles.header1),
              const SizedBox(height: 8),
              controller.transactions.isEmpty
                  ? ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      var transaction = controller.transactions[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              transaction.transactionType ==
                                      TransactionTypeEnums.income
                                  ? Colors.green
                                  : Colors.red,
                          child: Icon(
                            transaction.transactionType ==
                                    TransactionTypeEnums.income
                                ? FontAwesomeIcons.arrowUp
                                : FontAwesomeIcons.arrowDown,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          transaction.reason,
                          style: AppTextStyles.title,
                        ),
                        subtitle: Text(
                          transaction.date.toString(),
                          style: AppTextStyles.subtitle,
                        ),
                        trailing: Text(
                          "${transaction.amount} ${transaction.currency}",
                          style: AppTextStyles.label,
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
