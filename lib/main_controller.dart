import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pbma/core.dart';

class MainController extends GetxController {
  static final String TAG = "tMain";

  final UserRepository userRepository = Get.put(UserRepository());
  final TargetRepository targetRepository = Get.put(TargetRepository());
  final TransactionRepository transactionRepository = Get.put(
    TransactionRepository(),
  );
  final MemberRepository memberRepository = Get.put(MemberRepository());
  final BudgetRepository budgetRepository = Get.put(BudgetRepository());
  final TransactionFirebaseRepository transactionFirebaseRepository = Get.put(
    TransactionFirebaseRepository(),
  );
  final UserFirebaseRepository userFirebaseRepository = Get.put(
    UserFirebaseRepository(),
  );
  final MemberFirebaseRepository memberFirebaseRepository = Get.put(
    MemberFirebaseRepository(),
  );
  final BudgetFirebaseRepository budgetFirebaseRepository = Get.put(
    BudgetFirebaseRepository(),
  );
  final NotificationFirebaseRepository notificationFirebaseRepository = Get.put(
    NotificationFirebaseRepository(),
  );
  final BankCardFirebaseRepository bankCardFirebaseRepository = Get.put(
    BankCardFirebaseRepository(),
  );

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) => _currentIndex.value = index;

  final _title = 'Good'.obs;
  String get title => _title.value;
  set title(String title) => _title.value = title;

  final _user = UserModel().obs;
  UserModel get user => _user.value;
  set user(UserModel user) => _user.value = user;

  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;
  set isLogin(bool isLogin) => _isLogin.value = isLogin;

  final _isRegistered = false.obs;
  bool get isRegistered => _isRegistered.value;
  set isRegistered(bool isRegistered) => _isRegistered.value = isRegistered;

  final _currentLocation = LatLng(0, 0).obs;
  LatLng get currentLocation => _currentLocation.value;
  set currentLocation(LatLng value) => _currentLocation.value = value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  late GoogleMapController mapController;

  final List<Widget> children = [
    HomeScreen(),
    HistoryScreen(),
    MemberScreen(),
    BudgetScreen(),
    AccountScreen(),
  ];

  @override
  void onInit() async {
    await setData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sayHi() async {
    var now = DateTime.now();
    var hour = now.hour;
    if (hour < 12) {
      title = 'Good Morning!'.tr;
    } else if (hour < 17) {
      title = 'Good Afternoon!'.tr;
    } else {
      title = 'Good Evening!'.tr;
    }
  }

  Future onTabSelected(int index) async {
    currentIndex = index;
  }

  Future<void> showMapSelectAddress(Function(String address) handler) async {
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
                    Positioned(
                      left: 16,
                      top: 16,
                      right: 16,
                      bottom: 16,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Search Location'.tr,
                          labelStyle: AppTextStyles.label,
                          hintText: 'Phnom Penh, Cambodia',
                          hintStyle: AppTextStyles.hint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppDimensions.padding),
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.magnifyingGlass),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomGesturesEnabled: false,
                        mapType: MapType.hybrid,
                        onMapCreated: (GoogleMapController controller) async {
                          await onMapCreated(controller);
                        },
                        onTap: (LatLng latLng) async {
                          currentLocation = latLng;

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
                    ),

                    Positioned(
                      bottom: Get.width * .2,
                      left: 32,
                      right: 32,
                      child: FloatingActionButton(
                        onPressed: () async {
                          await Future.delayed(Duration(milliseconds: 300));
                          await getAddressFromLatLong(
                            currentLocation.latitude,
                            currentLocation.longitude,
                          ).then((value) {
                            handler(value);
                          });
                          Get.back();
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

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    isLoading = false;

    await _handleRetrieveCurrentLocation();
  }

  Future<void> _handleRetrieveCurrentLocation() async {
    await getCurrentLocation().then((value) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(value.latitude, value.longitude),
            zoom: AppConstants.zoomLevel,
          ),
        ),
      );
      currentLocation = LatLng(value.latitude, value.longitude);
    });
  }

  Future<LatLng> getCurrentLocation() async {
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

    var currentLocation = LatLng(position.latitude, position.longitude);
    return currentLocation;
  }

  Future<String> getAddressFromLatLong(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placemarks[0];

      String formattedAddress =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      return formattedAddress;
    } catch (e) {
      debugPrint("$TAG: Error getting address: $e");
      return "";
    }
  }

  Future<void> checkedUser() async {
    var users = await userRepository.gets() ?? [];
    if (users.isNotEmpty) {
      user = users.first;
    }

    for (var element in users) {
      debugPrint("$TAG: $element");
    }

    isLogin = users.isNotEmpty && user.isLogin;
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      Get.offAndToNamed(AppRoutes.login)?.then((value) {
        if (value != null && value) {
          setData();
        }
      });
    });
  }

  Future<void> gotoProfile() async {
    await checkedUser();
    if (isLogin) {
      await Future.delayed(const Duration(milliseconds: 300), () {
        Get.toNamed(AppRoutes.profile)?.then((value) {
          if (value != null && value) {
            setData();
          }
        });
      });
    } else {
      await gotoLogin();
    }
  }

  Future<void> showImagePicker(Function(XFile? file) handler) async {
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
                    style: AppTextStyles.title,
                  ),
                  onTap: () async {
                    Get.back();

                    await Future.delayed(Duration(milliseconds: 300));
                    var image = await ImagePicker().pickImage(
                      source: source,
                      maxHeight: 500,
                      maxWidth: 500,
                      imageQuality: 85,
                    );
                    handler(image);
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> onResetTab() async {
    AppUtils.showLoading();
    await Future.delayed(const Duration(seconds: 1), () async {
      AppUtils.hideLoading();

      currentIndex = 0;
      onTabSelected(currentIndex);
    });
  }

  Future<void> showCurrencySelected({
    required Function(CurrencyEnums currency) handler,
  }) async {
    await showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children:
              CurrencyEnums.values.map((element) {
                return ListTile(
                  leading: Icon(element.icon),
                  title: Text(element.name, style: AppTextStyles.title),
                  subtitle: Text(
                    element.description,
                    style: AppTextStyles.subtitle,
                  ),
                  onTap: () {
                    Get.back();
                    handler(element);
                  },
                );
              }).toList(),
        );
      },
    );
  }

  Future<void> showDateTimePicker({
    required Function(DateTime value) handler,
  }) async {
    await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      calendarDelegate: GregorianCalendarDelegate(),
    ).then((value) {
      if (value != null) {
        handler(value);
      }
    });
  }

  Future<void> setData() async {
    await checkedUser();
    await sayHi();
    Map<String, String> keys = await PGPUtil.generateKeyPair(
      name: "Sophanit KONG",
      email: "sophanit.9108@mail.com",
    );

    debugPrint("$TAG: ${keys['publicKey']}");
    debugPrint("$TAG: ${keys['privateKey']}");

    await PGPUtil.sign(
      plainText: "plainText",
      privateKey: keys['privateKey']!,
      passphrase: "passphrase",
    );

    await PGPUtil.verify(
      plainText: "plainText",
      signature: "signature",
      publicKey: keys['publicKey']!,
    );
  }

  Future<void> biometricAuth() async {
    final localAuth = LocalAuthentication();

    try {
      AppUtils.showLoading();

      final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to login'.tr,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        await setData();
        AppUtils.hideLoading();
        Get.offAllNamed(AppRoutes.main);
      } else {
        AppUtils.hideLoading();
      }
    } catch (e) {
      AppUtils.hideLoading();
    }
  }

  Future<void> gotoCreateTransaction() async {
    await Future.delayed(const Duration(milliseconds: 300));
    await checkedUser();

    if (!isLogin) {
      await gotoLogin();
      return;
    }

    Get.toNamed(AppRoutes.createTransaction)?.then((value) {
      if (value != null && value) {
        setData();
      }
    });
  }
}
