import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pbma/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setApplicationConfigs();
  setControllers();

  runApp(const MainApp());
}

void setControllers() {
  Get.put(MainController());
  Get.put(HomeController());
  Get.put(HistoryController());
  Get.put(SettingController());
  Get.put(CategoryController());
  Get.put(NotificationController());
}

void setApplicationConfigs() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
      routes: AppRoutes.routes,
      transitionDuration: Duration(milliseconds: 300),
      translations: AppTranslations(),
      defaultTransition: Transition.leftToRightWithFade,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('km', 'KH'),
        Locale('ja', 'JP'),
        Locale('zh', 'CN'),
      ],
      home: MainScreen(),
    );
  }
}
