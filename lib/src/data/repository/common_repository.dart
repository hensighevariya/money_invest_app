import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

final class CommonRepository extends BaseRepository {
  CommonRepository({
    required this._localStorageService,
    required this._apiClientService,
    required this._firebaseService,
    required AppEnvironment environment,
  });

  final LocalStorageService _localStorageService;
  final ApiClientService _apiClientService;
  final FirebaseService _firebaseService;

  Stream<RemoteMessage> get onRemoveMessage {
    _firebaseService.getToken();
    return _firebaseService.getOnMessageStream();
  }

  Stream<RemoteMessage> get onRemoteMessageOpenedApp => _firebaseService.getOnMessageOpenedAppStream();

  Future<RemoteMessage?> get initialMessage => _firebaseService.getInitialMessage();

  bool shouldShowIntro() {
    return _localStorageService.sessionToken == null && _localStorageService.showIntro;
  }

  void introCompleted() {
    _localStorageService.showIntro = false;
  }

  String? getLanguageCode() {
    return _localStorageService.languageCode;
  }

  void updateLanguageCode(String languageCode) {
    _localStorageService.languageCode = languageCode;
  }


  Future<AppVersionData?> getVersionData() async {
    try {
      if (kIsWeb) return null;
      final responseData = await _apiClientService.getVersionData(Platform.operatingSystem);
      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<void> redirectToStore() async {
    String storeDeeplinkUrl;
    String storeUniversalUrl;

    if (Platform.isAndroid) {
      storeDeeplinkUrl = AppConstants.playStoreDeepLink;
      storeUniversalUrl = AppConstants.playStoreUniversalLink;
    } else if (Platform.isIOS) {
      storeDeeplinkUrl = AppConstants.appStoreDeepLink;
      storeUniversalUrl = AppConstants.appStoreUniversalLink;
    } else {
      throw UnsupportedError('Platform not supported!');
    }

    bool canLaunchUrl = await canLaunchUrlString(storeDeeplinkUrl);
    if (canLaunchUrl) {
      launchUrlString(storeDeeplinkUrl, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      launchUrlString(storeUniversalUrl, mode: LaunchMode.externalApplication);
    }
  }
}
