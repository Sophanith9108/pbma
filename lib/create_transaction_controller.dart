import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbma/core.dart';

class CreateTransactionController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _purposeController = TextEditingController().obs;
  TextEditingController get purposeController => _purposeController.value;
  set purposeController(TextEditingController value) =>
      _purposeController.value = value;

  final _amountController = TextEditingController().obs;
  TextEditingController get amountController => _amountController.value;
  set amountController(TextEditingController value) =>
      _amountController.value = value;

  final _currencyController = TextEditingController().obs;
  TextEditingController get currencyController => _currencyController.value;
  set currencyController(TextEditingController value) =>
      _currencyController.value = value;

  final _expenseTypeController = TextEditingController().obs;
  TextEditingController get expenseTypeController =>
      _expenseTypeController.value;
  set expenseTypeController(TextEditingController value) =>
      _expenseTypeController.value = value;

  final _reasonController = TextEditingController().obs;
  TextEditingController get reasonController => _reasonController.value;
  set reasonController(TextEditingController value) =>
      _reasonController.value = value;

  final _paymentMethodController = TextEditingController().obs;
  TextEditingController get paymentMethodController =>
      _paymentMethodController.value;
  set paymentMethodController(TextEditingController value) =>
      _paymentMethodController.value = value;

  final _isOthersInvolved = false.obs;
  bool get isOthersInvolved => _isOthersInvolved.value;
  set isOthersInvolved(bool value) => _isOthersInvolved.value = value;

  final _dateController = TextEditingController().obs;
  TextEditingController get dateController => _dateController.value;
  set dateController(TextEditingController value) =>
      _dateController.value = value;

  final _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;

  final _timeController = TextEditingController().obs;
  TextEditingController get timeController => _timeController.value;
  set timeController(TextEditingController value) =>
      _timeController.value = value;

  final _locationController = TextEditingController().obs;
  TextEditingController get locationController => _locationController.value;
  set locationController(TextEditingController value) =>
      _locationController.value = value;

  final _attachmentController = TextEditingController().obs;
  TextEditingController get attachmentController => _attachmentController.value;
  set attachmentController(TextEditingController value) =>
      _attachmentController.value = value;

  final _othersInvolvedController = TextEditingController().obs;
  TextEditingController get othersInvolvedController =>
      _othersInvolvedController.value;
  set othersInvolvedController(TextEditingController value) =>
      _othersInvolvedController.value = value;

  final _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 12).obs;
  CameraPosition get initialCameraPosition => _initialCameraPosition.value;
  set initialCameraPosition(CameraPosition value) =>
      _initialCameraPosition.value = value;

  final _address = ''.obs;
  String get address => _address.value;
  set address(String value) => _address.value = value;

  final _selectedGender = GenderEnums.values.first.obs;
  GenderEnums get selectedGender => _selectedGender.value;
  set selectedGender(GenderEnums value) => _selectedGender.value = value;

  final _selectedCurrency = CurrencyEnums.values.first.obs;
  CurrencyEnums get selectedCurrency => _selectedCurrency.value;
  set selectedCurrency(CurrencyEnums value) => _selectedCurrency.value = value;

  final _selectedExpenseType = ExpenseTypeEnums.values.first.obs;
  ExpenseTypeEnums get selectedExpenseType => _selectedExpenseType.value;
  set selectedExpenseType(ExpenseTypeEnums value) =>
      _selectedExpenseType.value = value;

  final _selectedPaymentMethod = PaymentMethodEnums.values.first.obs;
  PaymentMethodEnums get selectedPaymentMethod => _selectedPaymentMethod.value;
  set selectedPaymentMethod(PaymentMethodEnums value) =>
      _selectedPaymentMethod.value = value;

  final _bankCardController = TextEditingController().obs;
  TextEditingController get bankCardController => _bankCardController.value;
  set bankCardController(TextEditingController value) =>
      _bankCardController.value = value;

  final _selectedBankCard = BankCardModel().obs;
  BankCardModel get selectedBankCard => _selectedBankCard.value;
  set selectedBankCard(BankCardModel value) => _selectedBankCard.value = value;

  final _bankCards = <BankCardModel>[].obs;
  List<BankCardModel> get bankCards => _bankCards;
  set bankCards(List<BankCardModel> value) => _bankCards.value = value;

  final _othersInvolved = <MemberModel>[].obs;
  List<MemberModel> get othersInvolved => _othersInvolved;
  set othersInvolved(List<MemberModel> value) => _othersInvolved.value = value;

  final _selectedOthersInvolved = <MemberModel>[].obs;
  List<MemberModel> get selectedOthersInvolved => _selectedOthersInvolved;
  set selectedOthersInvolved(List<MemberModel> value) =>
      _selectedOthersInvolved.value = value;

  final _attachments = <AttachmentModel>[].obs;
  List<AttachmentModel> get attachments => _attachments;
  set attachments(List<AttachmentModel> value) => _attachments.value = value;

  late GoogleMapController mapController;

  static const double zoomLevel = 12;

  @override
  void onInit() async {
    await checkedUser();
    await _handleRetrievedBanks();
    await _handleRetrievedMembers();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    await _handleRetrievedBanks();
    await _handleRetrievedMembers();
  }

  Future<void> _handleRetrievedBanks() async {
    AppUtils.showLoading();
    await bankCardFirebaseRepository.reads().then((value) {
      AppUtils.hideLoading();
      bankCards = value;
    });
  }

  Future<void> _handleRetrievedMembers() async {
    await AppUtils.delay();

    await memberFirebaseRepository.reads().then((value) {
      othersInvolved =
          value.where((element) {
            return element.id != user.id &&
                user.isLogin &&
                element.status == UserStatusEnums.active;
          }).toList();
    });
  }

  Future<void> onCreateTransaction() async {
    await AppUtils.delay();

    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();

    await checkedUser();

    var transaction = TransactionModel.create(
      purpose: purposeController.text.trim(),
      amount: double.tryParse(amountController.text) ?? 0.0,
      currency: selectedCurrency,
      expenseType: selectedExpenseType,
      reason: reasonController.text.trim(),
      paymentMethod: selectedPaymentMethod,
      bankCard: selectedBankCard,
      isOthersInvolved: isOthersInvolved,
      date: selectedDate,
      time: timeController.text,
      location: address.trim(),
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
      createdBy: user,
      updatedBy: user,
      updatedAt: DateTime.now(),
      status: TransactionStatusEnums.success,
      transactionType: TransactionTypeEnums.expense,
      othersInvolved: isOthersInvolved ? selectedOthersInvolved : [],
      attachments: attachments,
    );

    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      await transactionRepository.save(transaction);
      await transactionFirebaseRepository.create(transaction);

      await _onClear();

      await homeController.onRefreshing();
      await transactionController.onRefreshing();
      await memberController.onRefreshing();
      await accountController.onRefreshing();

      AppUtils.hideLoading();

      Get.back(result: true);
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();
      mapController = controller;

      await getCurrentLocation().then((value) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: zoomLevel,
            ),
          ),
        );
        currentLocation = LatLng(value.latitude, value.longitude);
        getAddressFromLatLong(
          value.latitude,
          value.longitude,
        ).then((value) => address = value);
      });
    });
  }

  Future<void> _onClear() async {
    formKey.currentState!.reset();
    purposeController.clear();
    amountController.clear();
    currencyController.clear();
    expenseTypeController.clear();
    reasonController.clear();
    paymentMethodController.clear();
    dateController.clear();
    timeController.clear();
    locationController.clear();
    othersInvolvedController.clear();
    selectedOthersInvolved.clear();
    isOthersInvolved = false;
    attachments.clear();
    attachmentController.clear();
    selectedBankCard = BankCardModel();
    bankCardController.clear();
    othersInvolved.clear();
  }

  void onDropLocation() {
    locationController.text = address;
  }

  Future<void> onAddressSelected() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await showMapSelectAddress((value) {
      address = value;
      locationController.text = value;
    });
  }

  Future<void> gotoCreateBankCard() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Get.toNamed(AppRoutes.createBankCard)?.then((value) async {
      if (value != null && value) {
        await _handleRetrievedBanks();
      }
    });
  }

  Future<void> onBankCardsSelected() async {
    await AppUtils.delay();
    await _handleRetrievedBanks();

    if (bankCards.isEmpty) {
      await gotoCreateBankCard();
      return;
    }

    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              bankCards.map((element) {
                return ListTile(
                  leading: Icon(element.paymentNetwork.icon),
                  title: Text(element.bankName, style: AppTextStyles.title),
                  subtitle: Text(
                    element.cardType.name,
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () async {
                    Get.back();

                    await _handleSelectedBankCard(element);
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> _handleSelectedBankCard(BankCardModel element) async {
    await AppUtils.delay();
    selectedBankCard = element;
    bankCardController.text = element.bankName;
  }

  Future<void> onOthersInvolvedSelected() async {
    await AppUtils.delay();

    if (othersInvolved.isEmpty) {
      Get.toNamed(AppRoutes.createMember)?.then((value) async {
        if (value != null && value) {
          await _handleRetrievedMembers();
        }
      });
      return;
    }

    await showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      isDismissible: true,
      showDragHandle: true,
      builder: (_) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: othersInvolved.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final member = othersInvolved[index];

            return ListTile(
              onTap: () async {
                await AppUtils.delay();

                Get.back();

                member.isSelected = !member.isSelected;

                await _handleSelectedWhomeInvolved(member);
              },
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                backgroundImage: MemoryImage(
                  base64Decode(member.profilePicture),
                ),
              ),
              title: Text(member.name, style: AppTextStyles.title),
              subtitle: Text(member.phone, style: AppTextStyles.subtitle),
              trailing: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.xsborderRadius,
                  ),
                ),
                activeColor: AppColors.primary,
                value: member.isSelected,
                onChanged: (value) async {
                  await AppUtils.delay();

                  Get.back();

                  member.isSelected = value!;

                  await _handleSelectedWhomeInvolved(member);
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleSelectedWhomeInvolved(MemberModel member) async {
    if (member.isSelected) {
      selectedOthersInvolved.add(member);
    } else {
      selectedOthersInvolved.remove(member);
    }
    othersInvolvedController.text = selectedOthersInvolved
        .map((e) {
          return e.name;
        })
        .join(', ');
  }

  Future<void> onAttachmentSelected() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (attachments.length >= AppConstants.maxAttachments) {
      AppUtils.showError(
        "You can only attach up to ${AppConstants.maxAttachments} photos".tr,
      );
      return;
    }

    await showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      isDismissible: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children:
              ImageSource.values.map((element) {
                return ListTile(
                  onTap: () async {
                    Get.back();
                    await _handleAttachments(element);
                  },
                  leading: Icon(
                    element == ImageSource.camera
                        ? FontAwesomeIcons.camera
                        : FontAwesomeIcons.image,
                  ),
                  title: Text(
                    element.name.capitalizeFirst!.tr,
                    style: AppTextStyles.title,
                  ),
                  subtitle: Text(
                    "Select the photo you want to attach".tr,
                    style: AppTextStyles.subtitle,
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> _handleAttachments(ImageSource element) async {
    await AppUtils.delay();
    final image = await ImagePicker().pickImage(source: element);
    if (image != null) {
      var imageBase64 = base64Encode(File(image.path).readAsBytesSync());
      var size = await AppUtils.getSizeFromBase64(imageBase64);

      var attachment = AttachmentModel.create(
        name: image.path,
        image: imageBase64,
        createdBy: user,
        type: image.mimeType,
        size: size,
      );

      attachments.add(attachment);

      attachmentController.text = attachments
          .map((e) {
            return "Attachment ${attachments.indexOf(e) + 1}";
          })
          .join(', ');
    }
  }

  Future<void> onAttachmentRemoved(AttachmentModel element) async {
    await AppUtils.delay();
    attachments.remove(element);
    attachmentController.text = attachments
        .map((e) {
          return "Attachment ${attachments.indexOf(e) + 1}";
        })
        .join(', ');
  }
}
