import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    controller.setData();

    return Obx(
      () => AppNavigation(
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            Fluttertoast.showToast(msg: "Successfully refreshing data!".tr);
          },
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              Text("Banks".tr, style: AppTextStyles.title),
              const SizedBox(height: 8),
              CarouselSlider(
                items: controller.banks,
                carouselController: controller.carouselController,
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: controller.selectedPage,
                  enableInfiniteScroll: false,
                  onPageChanged:
                      (index, reason) =>
                          controller.onPageChanged(index, reason),
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onScrolled: (value) => controller.onPageScrolled(value),
                ),
              ),
              const SizedBox(height: 8),
              Center(
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
              const SizedBox(height: AppDimensions.padding),
              Text("Credit Cards".tr, style: AppTextStyles.title),
              const SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: controller.creditCards,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
