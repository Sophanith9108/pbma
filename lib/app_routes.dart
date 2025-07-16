import 'package:flutter/material.dart';
import 'package:pbma/core.dart';

class AppRoutes {
  static const String main = '/main';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String home = '/home';
  static const String history = '/history';
  static const String category = '/category';
  static const String privacy = '/privacy';
  static const String help = '/help';
  static const String feedback = '/feedback';
  static const String notifications = '/notifications';
  static const String createTransaction = '/create_transaction';
  static const String createMember = "/create_member";
  static const String createBudget = "/create_budget";
  static const String createBankCard = "/create_bankcard";
  static const String forgetPassword = "/forget_password";

  static final Map<String, Widget Function(BuildContext)> routes = {
    main: (context) => MainScreen(),
    settings: (context) => SettingScreen(),
    home: (context) => HomeScreen(),
    history: (context) => HistoryScreen(),
    category: (context) => CategoryScreen(),
    notifications: (context) => NotificationScreen(),
    createTransaction: (context) => CreateTransactionScreen(),
    profile: (context) => ProfileScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    createMember: (context) => CreateMemberScreen(),
    createBudget: (context) => CreateBudgetScreen(),
    createBankCard: (context) => CreateBankCardScreen(),
    forgetPassword: (context) => ForgetPasswordScreen(),
  };
}
