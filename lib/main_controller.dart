import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbma/core.dart';

class MainController extends GetxController {
  static final String TAG = "tMain";

  final UserRepository userRepository = Get.put(UserRepository());

  final TransactionRepository transactionRepository = Get.put(
    TransactionRepository(),
  );

  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) => _currentIndex.value = index;

  final _title = 'Home'.obs;
  String get title => _title.value;
  set title(String title) => _title.value = title;

  final _isLogin = false.obs;
  bool get isLogin => _isLogin.value;
  set isLogin(bool isLogin) => _isLogin.value = isLogin;

  final _isRegistered = false.obs;
  bool get isRegistered => _isRegistered.value;
  set isRegistered(bool isRegistered) => _isRegistered.value = isRegistered;

  final List<Widget> children = [
    HomeScreen(),
    HistoryScreen(),
    CategoryScreen(),
    SettingScreen(),
    AccountScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  Future onTabSelected(int index) async {
    currentIndex = index;
    switch (index) {
      case 0:
        title = 'Home'.tr;
        break;
      case 1:
        title = 'Transactions'.tr;
        break;
      case 2:
        title = 'Subs'.tr;
        break;
      case 3:
        title = 'Budgets'.tr;
        break;
      case 4:
        title = 'Accounts'.tr;
        break;
      default:
        title = 'Home'.tr;
    }
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

  Future<void> gotoProfile() async {
    List<UserModel>? user = await userRepository.gets();
    if (user == null || user.isEmpty) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    var currentUser = await userRepository.get(user.last.id!);
    if (currentUser == null) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    await Future.delayed(const Duration(milliseconds: 300), () {
      Get.toNamed(AppRoutes.profile);
    });
  }
}
