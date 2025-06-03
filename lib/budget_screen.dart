import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class BudgetScreen extends StatelessWidget {
  BudgetScreen({super.key});

  final BudgetController controller = Get.put(BudgetController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.gotoCreateBudget();
          },
          label: Text("Budget".tr, style: AppTextStyles.button),
          icon: Icon(FontAwesomeIcons.googleWallet),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.onRefreshing(),
          child: ListView.builder(
            padding: EdgeInsets.only(
              left: AppDimensions.padding,
              right: AppDimensions.padding,
              top: AppDimensions.padding,
              bottom: Get.width * .2,
            ),
            itemCount: controller.budgets.length,
            itemBuilder: (context, index) {
              BudgetModel budget = controller.budgets[index];

              return Card.outlined(
                elevation: AppDimensions.elevation,
                margin: EdgeInsets.only(
                  bottom: AppDimensions.spadding,
                  top: AppDimensions.spadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  side: BorderSide(
                    width: 1.5,
                    color: Colors.grey.withValues(alpha: .5),
                  ),
                ),
                child: InkWell(
                  onTap: () => controller.onBudgetClicked(index),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadius,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(AppDimensions.padding),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${budget.id.split('-').first}-${budget.name.toUpperCase()}",
                                style: AppTextStyles.title,
                              ),
                              SizedBox(height: AppDimensions.spadding),
                              Text(budget.purpose, style: AppTextStyles.value),
                              SizedBox(height: AppDimensions.spadding),
                              Text(
                                "${budget.createdAt.format(pattern: AppConstants.budgetDateTimeFormat)} | ${budget.updatedAt.format(pattern: AppConstants.budgetDateTimeFormat)}",
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${budget.amount.toStringAsFixed(2)} ${budget.currency.name}",
                          style: AppTextStyles.amount,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
