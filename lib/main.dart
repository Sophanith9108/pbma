import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbma/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeStorage();
  await Firebase.initializeApp();

  runApp(MainApp());
}

Future<void> initializeStorage() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(GenderEnumsAdapter());
  Hive.registerAdapter(TargetEntityAdapter());
  Hive.registerAdapter(BudgetEntityAdapter());
  Hive.registerAdapter(UserRoleEnumsAdapter());
  Hive.registerAdapter(CurrencyEnumsAdapter());
  Hive.registerAdapter(ExpenseTypeEnumsAdapter());
  Hive.registerAdapter(TransactionEntityAdapter());
  Hive.registerAdapter(PaymentMethodEnumsAdapter());
  Hive.registerAdapter(TransactionTypeEnumsAdapter());
  Hive.registerAdapter(TransactionStatusEnumsAdapter());

  await Hive.openBox<UserEntity>(AppStorageBox.userBox);
  await Hive.openBox<UserEntity>(AppStorageBox.memberBox);
  await Hive.openBox<TargetEntity>(AppStorageBox.targetBox);
  await Hive.openBox<BudgetEntity>(AppStorageBox.budgetBox);
  await Hive.openBox<TransactionEntity>(AppStorageBox.transactionBox);
}

void setControllers() {
  Get.put(MainController());
  Get.put(HomeController());
  Get.put(LoginController());
  Get.put(ProfileController());
  Get.put(HistoryController());
  Get.put(SettingController());
  Get.put(AccountController());
  Get.put(RegisterController());
  Get.put(CategoryController());
  Get.put(NotificationController());
  Get.put(CreateTransactionController());
  Get.put(DetailTransactionController());
}

void setApplicationConfigs() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
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
      initialBinding: BindingsBuilder(() {
        setApplicationConfigs();
        setControllers();
      }),
      home: MainScreen(),
    );
  }
}
