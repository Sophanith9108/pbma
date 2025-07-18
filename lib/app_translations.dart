import 'package:get/get.dart';
import 'package:pbma/core.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': EnglishTranslation.translations,
    'km_KH': KhmerTranslation.translations,
    'ja_JP': JapaneseTranslation.translations,
    'zh_CN': ChineseTranslation.translations,
  };
}
