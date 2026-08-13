import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourguide_app/core/constants/storage_keys.dart';
import 'package:tourguide_app/core/localization/app_locales.dart';

/// Holds the app's active locale. `null` means "follow the device locale".
/// Persisted to SharedPreferences so the choice survives restarts and logout.
class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(null) {
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(StorageKeys.appLocale);
    if (code == null) return;

    final match = AppLocales.options.where(
      (o) => o.locale.languageCode == code,
    );
    if (match.isNotEmpty) emit(match.first.locale);
  }

  Future<void> setLocale(Locale locale) async {
    if (!AppLocales.isSupported(locale)) return;
    emit(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.appLocale, locale.languageCode);
  }

  /// Reverts to following the device's system locale.
  Future<void> useSystemLocale() async {
    emit(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(StorageKeys.appLocale);
  }
}
