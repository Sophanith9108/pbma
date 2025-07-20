class AppConstants {
  static const String appName = 'PBMA';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'PBMA is a mobile application that provides a platform for users to manage their tasks and projects efficiently.';
  static const String appAuthor = 'Sophanit KONG';
  static const String appAuthorEmail = 'sophanith.9108@gmail.com';
  static const String appAuthorWebsite = 'https://sophanit.dev';
  static const String appLicense = 'MIT License';
  static const String appLicenseUrl =
      'https://github.com/sophanith/pbma/blob/main/LICENSE';
  static const String appPrivacyPolicyUrl = '';
  static const String appTermsOfServiceUrl = '';
  static const String appSupportUrl = 'https://sophanit.dev/contact';
  static const String dateFormat = 'dd.MMM.yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String budgetDateTimeFormat = 'dd.MM.yy hh:mm a';
  static const double zoomLevel = 12.0;
}

class AppStorageBox {
  static const String transactionBox = 'transaction_box';
  static const String userBox = 'user_box';
  static const String categoryBox = 'category_box';
  static const String notificationBox = 'notification_box';
  static const String targetBox = 'target_box';
  static const String memberBox = "member_box";
  static const String budgetBox = "budget_box";
  static const String settingsBox = "settings_box";
}

class AppFirebaseReference {
  static const String root = "data";
  static const String devNode = "development";
  static const String preNode = "preproduction";
  static const String proNode = "production";

  static const String transaction = "transactions";
  static const String user = "users";
  static const String category = "categories";
  static const String setting = "settings";
  static const String notification = "notifications";
  static const String target = "targets";
  static const String member = "members";
  static const String budget = "budgets";
  static const String image = "images";
  static const String bankCard = "bankcards";
  static const String creditCard = "creditcards";
}
