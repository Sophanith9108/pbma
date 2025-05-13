import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {'welcome': 'Welcome to My App'},
    'km_KH': {'welcome': 'សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់ខ្ញុំ'},
    'ja_JP': {'welcome': '私のアプリへようこそ'},
    'zh_CN': {'welcome': '欢迎来到我的应用'},
  };
}
