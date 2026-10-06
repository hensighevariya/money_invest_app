import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class LocalStorageService {
  LocalStorageService(this._preferences);

  final SharedPreferencesWithCache _preferences;

  Future<void> clearData() async {
    final showIntro = this.showIntro;
    final languageCode = this.languageCode;

    await _preferences.clear();

    this.showIntro = showIntro;
    this.languageCode = languageCode;
  }

  bool get showIntro => _preferences.getBool('show_intro') ?? true;

  set showIntro(bool value) {
    _preferences.setBool('show_intro', value);
  }

  String? get languageCode => _preferences.getString('language_code');

  set languageCode(String? value) {
    _preferences.setString('language_code', value ?? 'en');
  }

  String? get sessionToken => _preferences.getString('session_token');

  set sessionToken(String? value) {
    if (value == null) {
      _preferences.remove('session_token');
      return;
    }
    _preferences.setString('session_token', value);
  }

  String? get refreshSessionToken =>
      _preferences.getString('refresh_session_token');

  set refreshSessionToken(String? value) {
    if (value == null) {
      _preferences.remove('refresh_session_token');
      return;
    }
    _preferences.setString('refresh_session_token', value);
  }

  UserData? get userData {
    String? userDataJson = _preferences.getString('user');
    if (userDataJson != null) {
      return UserData.fromJson(
        jsonDecode(userDataJson) as Map<String, dynamic>,
      );
    }
    return null;
  }

  set userData(UserData? value) {
    if (value == null) {
      _preferences.remove('user');
      return;
    }
    _preferences.setString('user', jsonEncode(value.toJson()));
  }

  ThemeMode get themeMode {
    final value = _preferences.getString('theme_mode');
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light; // Default as light
    }
  }

  set themeMode(ThemeMode mode) {
    String modeString;
    switch (mode) {
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
      case ThemeMode.light:
        modeString = 'light';
    }
    _preferences.setString('theme_mode', modeString);
  }
}
