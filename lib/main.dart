import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
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
  Hive.registerAdapter(UserStatusEnumsAdapter());
  Hive.registerAdapter(LanguagesEnumAdapter());
  Hive.registerAdapter(SettingsEntityAdapter());
  Hive.registerAdapter(MemberEntityAdapter());
  Hive.registerAdapter(AttachmentEntityAdapter());

  final userBox =
      kDebugMode
          ? 'debug_${AppStorageBox.userBox}'
          : kProfileMode
          ? 'profile_${AppStorageBox.userBox}'
          : AppStorageBox.userBox;

  final memberBox =
      kDebugMode
          ? 'debug_${AppStorageBox.memberBox}'
          : kProfileMode
          ? 'profile_${AppStorageBox.memberBox}'
          : AppStorageBox.memberBox;

  final targetBox =
      kDebugMode
          ? 'debug_${AppStorageBox.targetBox}'
          : kProfileMode
          ? 'profile_${AppStorageBox.targetBox}'
          : AppStorageBox.targetBox;

  final budgetBox =
      kDebugMode
          ? 'debug_${AppStorageBox.budgetBox}'
          : kProfileMode
          ? 'profile_${AppStorageBox.budgetBox}'
          : AppStorageBox.budgetBox;

  final transactionBox =
      kDebugMode
          ? 'debug_${AppStorageBox.transactionBox}'
          : kProfileMode
          ? 'profile_${AppStorageBox.transactionBox}'
          : AppStorageBox.transactionBox;

  final settingsBox =
      kDebugMode
          ? 'debug_${AppStorageBox.settingsBox}'
          : kProfileMode
          ? 'profile_${AppStorageBox.settingsBox}'
          : AppStorageBox.settingsBox;

  await Hive.openBox<UserEntity>(userBox);
  await Hive.openBox<UserEntity>(memberBox);
  await Hive.openBox<TargetEntity>(targetBox);
  await Hive.openBox<BudgetEntity>(budgetBox);
  await Hive.openBox<TransactionEntity>(transactionBox);
  await Hive.openBox<SettingsEntity>(settingsBox);
}

Future<void> setApplicationConfigs() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: controller.isDebug,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: controller.themeMode,
        routes: AppRoutes.routes,
        transitionDuration: Duration(milliseconds: 300),
        translations: AppTranslations(),
        defaultTransition: Transition.leftToRightWithFade,
        locale: controller.locale,
        fallbackLocale: controller.locale,
        supportedLocales: controller.supportedLocales,
        initialBinding: BindingsBuilder(() {
          setApplicationConfigs();
        }),
        home: MainScreen(),
      ),
    );
  }
}
