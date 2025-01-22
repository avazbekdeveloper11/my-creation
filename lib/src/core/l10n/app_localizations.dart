import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sovchilar_mobile/src/core/constants/constants.dart';

import 'cyrillic_cupertino_localizations.dart';
import 'cyrillic_material_localizations.dart';

final class AppLocalizations {
  AppLocalizations();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations) ?? _instance;

  static final AppLocalizations _instance = AppLocalizations();

  static AppLocalizations get instance => _instance;

  static Map<String, dynamic> _localizedValues = {};

  String translate(String key, {Map<String, String>? namedArgs}) {
    if (_localizedValues.isNotEmpty) {
      if (namedArgs != null) {
        String text = _localizedValues[key] ?? key;
        namedArgs.forEach(
          (key, value) {
            text = text.replaceAll('{$key}', value);
          },
        );
        return text;
      }
      return _localizedValues[key] ?? key;
    }
    return '';
  }

  Future<AppLocalizations> load(Locale locale) async {
    final String jsonContent = await rootBundle.loadString(
      'assets/locale/${locale.languageCode}.json',
    );
    _localizedValues = jsonDecode(jsonContent) as Map<String, dynamic>;
    return instance;
  }

  static const Iterable<LocalizationsDelegate> localizationsDelegates = [
    TranslationsDelegate(),
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    CyrillicMaterialLocalizations.delegate,
    CyrillicCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Constants.uzLan,
    Constants.ruLan,
    Constants.ozLan,
  ];
}

class TranslationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        Constants.ruLan.languageCode,
        Constants.uzLan.languageCode,
        Constants.ozLan.languageCode
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => await SynchronousFuture<AppLocalizations>(
        await AppLocalizations.instance.load(locale),
      );

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
