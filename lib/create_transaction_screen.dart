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
          onPressed: () => controller.createTransaction(),
          label: Text("Create".tr, style: AppTextStyles.button),
        ),
        body: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.all(AppDimensions.padding),
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell me what do u pay for?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "What do u pay for?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Tell me what is ur expense now?".tr,
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell me how much do u spend?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "How much is it?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Please tell me how much do u spend?".tr,
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
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell me what type of expense?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "What type of expense?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Please tell me the what do u spend on?".tr,
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
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell me why do u buy it?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Why do u buy it?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "U need to tell me why is it important?".tr,
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
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell me how do u pay?".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "What is the payment method?".tr,
                  labelStyle: AppTextStyles.label,
                  hintText: "Please tell me how do u pay?".tr,
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
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
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
