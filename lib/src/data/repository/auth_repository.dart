import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';

final class AuthRepository extends BaseRepository {
  AuthRepository({
    required LocalStorageService localStorageService,
    required ApiClientService apiClientService,
    required FirebaseService firebaseService,
    required AppEnvironment environment,
  }) : _localStorageService = localStorageService,
       _apiClientService = apiClientService,
       _firebaseService = firebaseService;

  final LocalStorageService _localStorageService;
  final ApiClientService _apiClientService;
  final FirebaseService _firebaseService;

  Future<String?> _getFirebaseToken() async {
    String? pushToken = await retry(
      _firebaseService.getToken,
      retryIf: (exception) => exception is FirebaseException,
      maxAttempts: 3,
      delayFactor: Durations.short2,
    ).catchError((_) => '');
    return pushToken;
  }

  Future<String> _getDeviceName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return '${androidInfo.brand} ${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.modelName;
    } else {
      throw UnimplementedError('This method is not implemented for other platforms.');
    }
  }

  void _onUserAuthenticated(AuthSuccessResponse response) {
    _localStorageService.sessionToken = response.sessionToken;
    _localStorageService.userIdentifier = response.user.uid;
    _localStorageService.userData = response.user;
  }

  Future<UserData> login({required String emailAddress, required String password}) async {
    try {
      final [pushToken, deviceName] = await Future.wait([_getFirebaseToken(), _getDeviceName()]);

      final responseData = await _apiClientService.userLogin(
        LoginRequest(email: emailAddress, password: password, pushToken: pushToken, deviceName: deviceName),
      );
      _onUserAuthenticated(responseData);
      return responseData.user;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<bool> userLogout() async {
    try {
      await _apiClientService.userLogout();
      return true;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }
}
