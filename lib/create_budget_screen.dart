import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateBudgetScreen extends StatelessWidget {
  CreateBudgetScreen({super.key});

  final CreateBudgetController controller = Get.put(CreateBudgetController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: 'Create Budget'.tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.onCreateBudget();
          },
          label: Text("Create Budget".tr, style: AppTextStyles.button),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              Text('Create Budget'.tr, style: AppTextStyles.title),
              SizedBox(height: AppDimensions.spadding),
              Text(
                'Please fill in the form below to create a budget'.tr,
                style: AppTextStyles.subtitle,
              ),
              SizedBox(height: AppDimensions.xlpadding),
              TextFormField(
                controller: controller.titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Budget title is required!".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: 'Saving'.tr,
                  labelText: 'Budget title'.tr,
                  prefixIcon: const Icon(Icons.title),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.titleController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.padding),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.xlpadding),
              Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: TextFormField(
                      controller: controller.amountController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(?!0\d)\d*(\.\d{0,2})?$'),
                        ),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Budget amount is required!".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle: AppTextStyles.label,
                        hintStyle: AppTextStyles.hint,
                        hintText: '10000'.tr,
                        labelText: 'Budget amount'.tr,
                        prefixIcon: const Icon(Icons.attach_money),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.amountController.clear();
                          },
                          icon: Icon(FontAwesomeIcons.xmark),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.padding),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.padding),
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: controller.currencyController,
                      readOnly: true,
                      onTap: () {
                        controller.showCurrencySelected(
                          handler: (CurrencyEnums currency) {
                            controller.selectedCurrency = currency;
                            controller.currencyController.text = currency.name;
                          },
                        );
                      },
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Currency?".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle: AppTextStyles.label,
                        hintStyle: AppTextStyles.hint,
                        hintText: 'USD'.tr,
                        labelText: 'Currency'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.padding),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.purposeController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Budget purpose is required!".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: 'Saving for my future'.tr,
                  labelText: 'Budget purpose'.tr,
                  prefixIcon: const Icon(Icons.description),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.purposeController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.padding),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.dateController,
                readOnly: true,
                onTap: () {
                  controller.showDateTime();
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Start month is required!".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelStyle: AppTextStyles.label,
                  hintStyle: AppTextStyles.hint,
                  hintText: 'Start month'.tr,
                  labelText: 'Start month'.tr,
                  prefixIcon: const Icon(Icons.date_range),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.dateController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.xmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.padding),
                    ),
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
