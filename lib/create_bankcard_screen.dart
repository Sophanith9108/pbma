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
    return AppNavigation(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.onAddBankCard();
        },
        label: Text("Add Card".tr, style: AppTextStyles.button),
        icon: const Icon(FontAwesomeIcons.creditCard),
      ),
    );
  }
}
