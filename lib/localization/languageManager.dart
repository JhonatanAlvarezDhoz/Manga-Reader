import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_reader/localization/translation.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._internal();
  static const List<String> supportedLanguages = ['es', 'en'];

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  Locale _currentLocale = const Locale('es');
  Map<String, String> _translations = {};

  Locale get currentLocale => _currentLocale;

  Future<void> loadTranslations() async {
    String content = await rootBundle
        .loadString('assets/i18n/${_currentLocale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(content);
    _translations = jsonMap.cast<String, String>();
  }

  Translation translate() {
    return Translation(_translations);
  }

  Future<void> changeLanguage(String languageCode) async {
    _currentLocale = Locale(languageCode);
    await loadTranslations();
  }
}
