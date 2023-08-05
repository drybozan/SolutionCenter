

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soltion_center/localization/Localization.dart';
import 'package:soltion_center/localization/en_lang.dart';
import 'package:soltion_center/localization/tr_lang.dart';
import 'package:soltion_center/view/widgets/dialog/language_dialog.dart';

enum LangDirection { right, left }

class LocalizationController with ChangeNotifier {
  final languageBox = Hive.box('language');

  final Map<String, Localization> languages = {
    'en': ENLocalization(),
    'tr': TRLocalization(),
  };

  LangDirection _langDirection = LangDirection.left;

  LangDirection getLangDirection() {
    return _langDirection;
  }


  void _setLangDirection() {
    if (_langDirection == getLanguage().langDirection) {
    } else {
      _langDirection = getLanguage().langDirection;
    }
    notifyListeners();
  }

  get getAppLang => languageBox.get('langCode', defaultValue: 'en');

  set setAppLang(String languageCode) {
    languageBox.put('langCode', languageCode);
    _setLangDirection();
    notifyListeners();
  }

  Map<String, String> getLanguageTitles() {
    return getLanguage().languageTitles!;
  }

  String getLanguageTitle() {
    return getLanguage().languageTitles![getAppLang]!;
  }

  Localization getLanguage() {
    return languages[getAppLang]!;
  }

  void getLanguageDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const LanguageDialog(),
    );
  }
}
