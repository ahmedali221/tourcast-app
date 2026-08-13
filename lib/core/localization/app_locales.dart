import 'package:flutter/material.dart';

/// A locale the app ships translations for, paired with its native display name.
/// Native names are shown as-is in language pickers, not translated by the
/// current UI language (e.g. Arabic always reads "العربية").
class AppLocaleOption {
  const AppLocaleOption(this.locale, this.nativeName, this.flag);

  final Locale locale;
  final String nativeName;
  final String flag;
}

/// Central list of locales the app ships translations for.
/// Keep in sync with the .arb files under lib/l10n/.
class AppLocales {
  AppLocales._();

  static const List<AppLocaleOption> options = [
    AppLocaleOption(Locale('en'), 'English', '🇬🇧'),
    AppLocaleOption(Locale('ar'), 'العربية', '🇸🇦'),
    AppLocaleOption(Locale('zh'), '中文', '🇨🇳'),
    AppLocaleOption(Locale('ru'), 'Русский', '🇷🇺'),
    AppLocaleOption(Locale('de'), 'Deutsch', '🇩🇪'),
    AppLocaleOption(Locale('fr'), 'Français', '🇫🇷'),
    AppLocaleOption(Locale('tr'), 'Türkçe', '🇹🇷'),
    AppLocaleOption(Locale('it'), 'Italiano', '🇮🇹'),
    AppLocaleOption(Locale('es'), 'Español', '🇪🇸'),
    AppLocaleOption(Locale('ja'), '日本語', '🇯🇵'),
    AppLocaleOption(Locale('ko'), '한국어', '🇰🇷'),
  ];

  static bool isSupported(Locale locale) => options.any(
    (option) => option.locale.languageCode == locale.languageCode,
  );
}
