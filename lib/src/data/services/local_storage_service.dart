import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class LocalStorageService {
  LocalStorageService(this._preferences);

  final SharedPreferencesWithCache _preferences;

  Future<void> clearData() async {
    final showIntro = this.showIntro;
    final languageCode = this.languageCode;
    final notificationStatus = this.notificationStatus;
    final preferredStreamQuality = this.preferredStreamQuality;

    await _preferences.clear();

    this.showIntro = showIntro;
    this.languageCode = languageCode;
    this.notificationStatus = notificationStatus;
    this.preferredStreamQuality = preferredStreamQuality;
  }

  bool get showIntro => _preferences.getBool('show_intro') ?? true;

  set showIntro(bool value) {
    _preferences.setBool('show_intro', value);
  }

  String? get languageCode => _preferences.getString('language_code');

  set languageCode(String? value) {
    if (value == null) {
      _preferences.remove('language_code');
      return;
    }
    _preferences.setString('language_code', value);
  }

  bool get notificationStatus => _preferences.getBool('notification_status') ?? true;

  set notificationStatus(bool? value) {
    if (value == null) {
      _preferences.remove('notification_status');
      return;
    }
    _preferences.setBool('notification_status', value);
  }

  bool get autoUnlockStatus => _preferences.getBool('auto_unlock') ?? false;

  set autoUnlockStatus(bool? value) {
    if (value == null) {
      _preferences.remove('auto_unlock');
      return;
    }
    _preferences.setBool('auto_unlock', value);
  }

  String? get preferredStreamQuality => _preferences.getString('stream_quality');

  set preferredStreamQuality(String? value) {
    if (value == null) {
      _preferences.remove('stream_quality');
      return;
    }
    _preferences.setString('stream_quality', value);
  }

  String? get preferredDownloadQuality => _preferences.getString('download_quality');

  set preferredDownloadQuality(String? value) {
    if (value == null) {
      _preferences.remove('download_quality');
      return;
    }
    _preferences.setString('download_quality', value);
  }

  String? get sessionToken => _preferences.getString('session_token');

  set sessionToken(String? value) {
    if (value == null) {
      _preferences.remove('session_token');
      return;
    }
    _preferences.setString('session_token', value);
  }

  String? get userIdentifier => _preferences.getString('user_identifier');

  set userIdentifier(String? value) {
    if (value == null) {
      _preferences.remove('user_identifier');
      return;
    }
    _preferences.setString('user_identifier', value);
  }

  UserData? get userData {
    String? userDataJson = _preferences.getString('user');
    if (userDataJson != null) {
      return UserData.fromJson(jsonDecode(userDataJson) as Map<String, dynamic>);
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
}
