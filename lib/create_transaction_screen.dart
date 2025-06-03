import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

class CreateTransactionScreen extends StatelessWidget {
  CreateTransactionScreen({super.key});

  final CreateTransactionController controller =
      Get.find<CreateTransactionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppNavigation(
        title: "Create Transaction".tr,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.onCreateTransaction(),
          label: Text("Create Transaction".tr, style: AppTextStyles.button),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              TextFormField(
                controller: controller.purposeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "What do u buy?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "What do u pay for?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "What do u buy?".tr,
                  hintStyle: AppTextStyles.hint,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: controller.amountController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "How much?".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "How much is it?".tr,
                        labelStyle: AppTextStyles.label,
                        hintText: "How much?".tr,
                        hintStyle: AppTextStyles.hint,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.borderRadius),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.padding),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: controller.currencyController,
                      readOnly: true,
                      onTap: () {
                        controller.showCurrencySelected(
                          handler: (CurrencyEnums currency) {
                            controller.currencyController.text = currency.name;
                          },
                        );
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Currency?".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Currency?".tr,
                        labelStyle: AppTextStyles.label,
                        hintText: "USD".tr,
                        hintStyle: AppTextStyles.hint,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.borderRadius),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.expenseTypeController,
                readOnly: true,
                onTap: () {
                  showModalBottomSheet(
                    context: Get.context!,
                    showDragHandle: true,
                    useSafeArea: true,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (_) {
                      return ListView(
                        shrinkWrap: true,
                        children:
                            ExpenseTypeEnums.values.map((element) {
                              return ListTile(
                                leading: Icon(element.icon),
                                title: Text(
                                  element.name,
                                  style: AppTextStyles.title,
                                ),
                                subtitle: Text(
                                  element.description,
                                  style: AppTextStyles.subtitle,
                                ),
                                onTap: () async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 300),
                                  );
                                  controller.expenseTypeController.text =
                                      element.name;
                                  controller.selectedExpenseType = element;
                                  Get.back();
                                },
                              );
                            }).toList(),
                      );
                    },
                  );
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Type of expense?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "What type of expense?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "What do u spend on?".tr,
                  hintStyle: AppTextStyles.hint,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.reasonController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Why do u buy it?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Why do u buy it?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Why is it important?".tr,
                  hintStyle: AppTextStyles.hint,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                controller: controller.paymentMethodController,
                readOnly: true,
                onTap: () {
                  showModalBottomSheet(
                    context: Get.context!,
                    showDragHandle: true,
                    useSafeArea: true,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (_) {
                      return ListView(
                        shrinkWrap: true,
                        children:
                            PaymentMethodEnums.values.map((element) {
                              return ListTile(
                                leading: Icon(element.icon),
                                title: Text(
                                  element.name,
                                  style: AppTextStyles.title,
                                ),
                                subtitle: Text(
                                  element.description,
                                  style: AppTextStyles.subtitle,
                                ),
                                onTap: () async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 300),
                                  );
                                  controller.paymentMethodController.text =
                                      element.name;
                                  controller.selectedPaymentMethod = element;
                                  Get.back();
                                },
                              );
                            }).toList(),
                      );
                    },
                  );
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "How do u pay?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Payment method?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "How do u pay?".tr,
                  hintStyle: AppTextStyles.hint,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: controller.dateController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.datetime,
                      textCapitalization: TextCapitalization.sentences,
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        ).then((value) {
                          if (value != null) {
                            controller.selectedDate = value;
                            controller.dateController.text = value.format(
                              pattern: "dd.MMM.yyyy",
                            );
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please tell me when do u pay?".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "What is the payment date?".tr,
                        labelStyle: AppTextStyles.label,
                        hintText: "Please tell me when do u pay?".tr,
                        hintStyle: AppTextStyles.hint,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.borderRadius),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.padding),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: controller.timeController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      readOnly: true,
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if (value != null) {
                            controller.timeController.text =
                                value.toTimeOfDay();
                          }
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "what time?".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "What time?".tr,
                        labelStyle: AppTextStyles.label,
                        hintText: "What time?".tr,
                        hintStyle: AppTextStyles.hint,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.borderRadius),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.padding),
              TextFormField(
                readOnly: true,
                controller: controller.locationController,
                onTap: () => controller.onAddressSelected(),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell me where do u pay?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Where do u pay?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Please tell me where do u pay?".tr,
                  hintStyle: AppTextStyles.hint,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius),
                    ),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.padding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Is there any people involve?".tr,
                    style: AppTextStyles.label,
                  ),
                  Switch(
                    value: controller.isOthersInvolved,
                    onChanged: (value) {
                      controller.isOthersInvolved = value;
                    },
                  ),
                ],
              ),
              Visibility(
                visible: controller.isOthersInvolved,
                child: Column(
                  children: [
                    SizedBox(height: AppDimensions.padding),
                    TextFormField(
                      controller: controller.othersInvolvedController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please tell me who do u pay for?".tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Who do u pay for?".tr,
                        labelStyle: AppTextStyles.label,
                        hintText: "Who is exactly?".tr,
                        hintStyle: AppTextStyles.hint,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppDimensions.borderRadius),
                          ),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppDimensions.padding * 6),
            ],
          ),
        ),
      ),
    );
  }
}
