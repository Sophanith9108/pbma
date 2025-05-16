import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(() => HomeController());

  @override
  Widget build(BuildContext context) {
    return AppNavigation(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 2)),
        child: ListView(
          padding: EdgeInsets.all(AppDimensions.padding),
          children: [
            Card.outlined(
              elevation: AppDimensions.elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                side: BorderSide(
                  width: 1.5,
                  color: Colors.grey.withValues(alpha: .5),
                ),
              ),
              child: SizedBox(
                height: 310,
                child: GridView.count(
                  padding: EdgeInsets.all(10),
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 4 / 3,
                  children: List.generate(4, (index) {
                    return Card.outlined(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius,
                        ),
                        side: BorderSide(
                          width: 1.5,
                          color: Colors.grey.withValues(alpha: .5),
                        ),
                      ),
                      elevation: AppDimensions.elevation,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius,
                        ),
                        onTap: () {},
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Card $index",
                            style: AppTextStyles.title,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
