import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  final _timeController = TextEditingController().obs;
  TextEditingController get timeController => _timeController.value;
  set timeController(TextEditingController value) =>
      _timeController.value = value;

  final _locationController = TextEditingController().obs;
  TextEditingController get locationController => _locationController.value;
  set locationController(TextEditingController value) =>
      _locationController.value = value;

  final _othersInvolvedController = TextEditingController().obs;
  TextEditingController get othersInvolvedController =>
      _othersInvolvedController.value;
  set othersInvolvedController(TextEditingController value) =>
      _othersInvolvedController.value = value;

  final _currentLocation = LatLng(0, 0).obs;
  LatLng get currentLocation => _currentLocation.value;
  set currentLocation(LatLng value) => _currentLocation.value = value;

  final _initialCameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 12).obs;
  CameraPosition get initialCameraPosition => _initialCameraPosition.value;
  set initialCameraPosition(CameraPosition value) =>
      _initialCameraPosition.value = value;

  final _address = ''.obs;
  String get address => _address.value;
  set address(String value) => _address.value = value;

  late GoogleMapController mapController;

  static const double zoomLevel = 12;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        timeLimit: Duration(seconds: 5),
      ),
    );

    currentLocation = LatLng(position.latitude, position.longitude);
    initialCameraPosition = CameraPosition(
      target: currentLocation,
      zoom: zoomLevel,
    );
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(initialCameraPosition),
    );
    _getAddressFromLatLong(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromLatLong(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placemarks[0];

      String formattedAddress =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      address = formattedAddress;
    } catch (e) {
      debugPrint("Error getting address: $e");
    }
  }

  Future onCreateTransaction() async {
    if (!formKey.currentState!.validate()) return;
    FocusScope.of(Get.context!).unfocus();

    AppUtils.showLoading();

    var user = UserModel.create(
      name: "John Doe",
      email: "bK2l0@example.com",
      phone: "1234567890",
      password: "password",
      profilePicture: "https://example.com/profile.jpg",
      address: "123 Main St, City, Country",
      dateOfBirth: "1990-01-01",
      gender: GenderEnums.values.first,
    );

    var transaction = TransactionModel.create(
      purpose: purposeController.text,
      amount: double.tryParse(amountController.text),
      currency: CurrencyEnums.values.first,
      expenseType: ExpenseTypeEnums.values.first,
      reason: reasonController.text,
      paymentMethod: PaymentMethodEnums.values.first,
      isOthersInvolved: isOthersInvolved,
      date: dateController.text,
      time: timeController.text,
      location: address,
      othersInvolved: isOthersInvolved ? othersInvolvedController.text : "",
      createdBy: user,
    );

    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();

      await transactionRepository.save(transaction);

      _onClear();
      await Future.delayed(Duration(seconds: 1));
      Get.back(result: true);
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 3), () async {
      AppUtils.hideLoading();

      mapController = controller;
      _getCurrentLocation();
    });
  }

  void _onClear() {
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
    isOthersInvolved = false;
  }

  void onDropLocation() {
    locationController.text = address;
  }
}
