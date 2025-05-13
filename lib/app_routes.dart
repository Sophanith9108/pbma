import 'package:flutter/material.dart';
import 'package:pbma/core.dart';

class AppRoutes {
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
  static const String transaction = '/transaction';

  static final Map<String, Widget Function(BuildContext)> routes = {
    settings: (context) => SettingScreen(),
    home: (context) => HomeScreen(),
    history: (context) => HistoryScreen(),
    category: (context) => CategoryScreen(),
    notifications: (context) => NotificationScreen(),
    transaction: (context) => TransactionScreen(),
  };
}
