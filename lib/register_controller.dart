import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbma/core.dart';

class RegisterController extends MainController {
  final _formKey = GlobalKey<FormState>().obs;
  GlobalKey<FormState> get formKey => _formKey.value;
  set formKey(GlobalKey<FormState> value) => _formKey.value = value;

  final _nameController = TextEditingController().obs;
  TextEditingController get nameController => _nameController.value;
  set nameController(TextEditingController value) =>
      _nameController.value = value;

  final _emailController = TextEditingController().obs;
  TextEditingController get emailController => _emailController.value;
  set emailController(TextEditingController value) =>
      _emailController.value = value;

  final _phoneController = TextEditingController().obs;
  TextEditingController get phoneController => _phoneController.value;
  set phoneController(TextEditingController value) =>
      _phoneController.value = value;

  final _passwordController = TextEditingController().obs;
  TextEditingController get passwordController => _passwordController.value;
  set passwordController(TextEditingController value) =>
      _passwordController.value = value;

  final _confirmPasswordController = TextEditingController().obs;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController.value;
  set confirmPasswordController(TextEditingController value) =>
      _confirmPasswordController.value = value;

  final _isAgreedWithTerms = false.obs;
  bool get isAgreedWithTerms => _isAgreedWithTerms.value;
  set isAgreedWithTerms(bool value) => _isAgreedWithTerms.value = value;

  final _profile = XFile('').obs;
  XFile get profile => _profile.value;
  set profile(XFile value) => _profile.value = value;

  final _addressController = TextEditingController().obs;
  TextEditingController get addressController => _addressController.value;
  set addressController(TextEditingController value) =>
      _addressController.value = value;

  final _currentLocation = LatLng(0, 0).obs;
  LatLng get currentLocation => _currentLocation.value;
  set currentLocation(LatLng value) => _currentLocation.value = value;

  late GoogleMapController mapController;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRegister() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(Get.context!).unfocus();

      if (!isAgreedWithTerms) {
        Fluttertoast.showToast(
          msg: 'Please agree with terms and conditions'.tr,
        );
        return;
      }

      var userExist = await userRepository.gets();
      if (userExist != null) {
        Fluttertoast.showToast(
          msg: 'User with this phone number already exists'.tr,
        );
        await Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(AppRoutes.login);
        });
        return;
      }

      var user = UserModel.create(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        profilePicture:
            profile.path.isNotEmpty
                ? profile.path
                : 'https://example.com/default-profile.png',
        address: addressController.text,
        dateOfBirth: DateTime.now().format(pattern: 'dd.MMM.yyyy'),
        gender: GenderEnums.male,
      );

      AppUtils.showLoading();
      await Future.delayed(const Duration(seconds: 3), () async {
        AppUtils.hideLoading();

        await userRepository
            .save(user)
            .then((response) {
              Fluttertoast.showToast(msg: 'Registration successful'.tr);
              Get.offAllNamed(AppRoutes.main);
            })
            .catchError((error) {
              Fluttertoast.showToast(
                msg: 'Registration failed: ${error.toString()}',
              );
            });
      });
    }
  }

  Future<void> onAgreeWithTerms() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Terms of Service'.tr,
                      style: AppTextStyles.title,
                    ),
                  ),
                  IconButton.outlined(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  left: AppDimensions.padding,
                  right: AppDimensions.padding,
                  bottom: AppDimensions.padding,
                ),
                children: [
                  Text(
                    'By agreeing to the terms of service, you agree to our terms and conditions.'
                    'Please read them carefully before proceeding.'
                    'If you do not agree with the terms, please do not use our services.'
                    'We reserve the right to modify these terms at any time, and it is your responsibility to review them periodically.'
                    'Your continued use of our services after any changes to the terms constitutes your acceptance of the new terms.'
                    'If you have any questions or concerns about the terms, please contact us.'
                    'Thank you for using our services.'
                    'We appreciate your understanding and cooperation.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.',
                    strutStyle: StrutStyle(height: 1.5),
                    style: AppTextStyles.text,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: Get.width * 0.1),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> onAgreeWithPolicy() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Privacy Policy'.tr,
                      style: AppTextStyles.title,
                    ),
                  ),
                  IconButton.outlined(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.padding,
                ),
                children: [
                  Text(
                    'By agreeing to the privacy policy, you agree to our terms and conditions.'
                    'Please read them carefully before proceeding.'
                    'If you do not agree with the terms, please do not use our services.'
                    'We reserve the right to modify these terms at any time, and it is your responsibility to review them periodically.'
                    'Your continued use of our services after any changes to the terms constitutes your acceptance of the new terms.'
                    'If you have any questions or concerns about the terms, please contact us.'
                    'Thank you for using our services.'
                    'We appreciate your understanding and cooperation.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We are here to help you and ensure that you have a positive experience with our services.'
                    'Thank you for your cooperation and understanding.'
                    'We look forward to serving you and providing you with the best possible experience.'
                    'If you have any questions or concerns, please feel free to reach out to us.'
                    'We reserve the right to modify these terms at any time, and it is your responsibility to review them periodically.',
                    style: AppTextStyles.text,
                    strutStyle: StrutStyle(height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: Get.width * 0.1),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> onSelectImage() async {
    showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              ImageSource.values.map((source) {
                return ListTile(
                  leading: Icon(
                    source == ImageSource.camera ? Icons.camera : Icons.photo,
                  ),
                  title: Text(
                    source == ImageSource.camera ? 'Camera'.tr : 'Gallery'.tr,
                  ),
                  onTap: () async {
                    await Future.delayed(Duration(milliseconds: 300));
                    var image = await ImagePicker().pickImage(source: source);
                    if (image != null) {
                      profile = image;
                    }
                    Get.back();
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onSelectAddress() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Select Address'.tr,
                        style: AppTextStyles.title,
                      ),
                    ),
                    IconButton.outlined(
                      icon: Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomGesturesEnabled: false,
                      mapType: MapType.hybrid,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;

                        AppUtils.showLoading();
                        Future.delayed(Duration(seconds: 3), () async {
                          await AppUtils.hideLoading();

                          await getCurrentLocation().then((value) {
                            mapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                    value.latitude,
                                    value.longitude,
                                  ),
                                  zoom: 12,
                                ),
                              ),
                            );
                            currentLocation = LatLng(
                              value.latitude,
                              value.longitude,
                            );
                            getAddressFromLatLong(
                              value.latitude,
                              value.longitude,
                            ).then((value) {
                              addressController.text = value;
                            });
                          });
                        });
                      },
                      onTap: (LatLng latLng) async {
                        currentLocation = latLng;

                        await getAddressFromLatLong(
                          currentLocation.latitude,
                          currentLocation.longitude,
                        );

                        mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: latLng, zoom: 12),
                          ),
                        );
                      },
                      markers: Set<Marker>.of(<Marker>{
                        Marker(
                          markerId: MarkerId('marker'),
                          position: currentLocation,
                          infoWindow: InfoWindow(
                            title: addressController.text,
                            snippet: addressController.text,
                          ),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue,
                          ),
                        ),
                      }),
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 12,
                      ),
                    ),
                    Positioned(
                      bottom: 32,
                      left: 32,
                      right: 32,
                      child: FloatingActionButton(
                        onPressed: () async {
                          Get.back();
                          addressController.text = await getAddressFromLatLong(
                            currentLocation.latitude,
                            currentLocation.longitude,
                          );
                        },
                        child: Text(
                          "Pick Location".tr,
                          style: AppTextStyles.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
