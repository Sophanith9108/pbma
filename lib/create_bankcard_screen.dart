import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateBankCardScreen extends StatelessWidget {
  CreateBankCardScreen({super.key});

  final CreateBankCardController controller = Get.put(
    CreateBankCardController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: "Add Bank Card".tr,
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.only(
              left: AppDimensions.padding,
              right: AppDimensions.padding,
              top: AppDimensions.padding,
              bottom: Get.width * .2,
            ),
            children: [
              Text("Add Bank Card".tr, style: AppTextStyles.title),
              Text(
                "Please fill all the requirements!".tr,
                style: AppTextStyles.subtitle,
              ),
              const Divider(),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.bankNameController,
                readOnly: true,
                onTap: () {
                  controller.onBankSelected();
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bank Name is required".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Bank Name".tr,
                  hintText: "Enter Bank Name".tr,
                  prefixIcon: const Icon(FontAwesomeIcons.buildingColumns),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.bankNameController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.circleXmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.padding),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.cardTypeController,
                readOnly: true,
                onTap: () {
                  controller.onCardTypeSelected();
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Card Type is required".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Card Type".tr,
                  hintText: "Card Type".tr,
                  prefixIcon: const Icon(FontAwesomeIcons.creditCard),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.cardTypeController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.circleXmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.padding),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.paymentNetworkController,
                readOnly: true,
                onTap: () {
                  controller.onCardBrandSelected();
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Card Brand is required".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Payment Network".tr,
                  hintText: "Payment Network".tr,
                  prefixIcon: const Icon(FontAwesomeIcons.creditCard),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.paymentNetworkController.clear();
                    },
                    icon: Icon(FontAwesomeIcons.circleXmark),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.padding),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: controller.cardBalanceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Card Balance is required".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Card Balance".tr,
                        hintText: "Enter Available Balance".tr,
                        prefixIcon: const Icon(FontAwesomeIcons.creditCard),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.cardBalanceController.clear();
                          },
                          icon: Icon(FontAwesomeIcons.circleXmark),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.padding,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.padding),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: controller.cardCurrencyController,
                      readOnly: true,
                      onTap: () {
                        controller.onCurrencySelected();
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Currency is required".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Currency".tr,
                        hintText: "Currency?".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.padding,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.cardCurrencyController.clear();
                          },
                          icon: Icon(FontAwesomeIcons.circleXmark),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.onAddBankCard();
          },
          label: Text("Save Bank".tr, style: AppTextStyles.button),
          icon: const Icon(FontAwesomeIcons.buildingColumns),
        ),
      ),
    );
  }
}
