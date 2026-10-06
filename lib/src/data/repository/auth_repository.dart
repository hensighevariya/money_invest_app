import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/enum.dart';
import 'package:retry/retry.dart';

final class AuthRepository extends BaseRepository {
  AuthRepository({
    required this._localStorageService,
    required this._apiClientService,
    required this._firebaseService,
    required AppEnvironment environment,
  });

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

  Future<String> _getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? iosInfo.modelName;
    } else {
      throw UnimplementedError(
        'This method is not implemented for other platforms.',
      );
    }
  }

  void _onUserAuthenticated(AuthSuccessResponse response) {
    _localStorageService.sessionToken = response.accessToken;
    _localStorageService.refreshSessionToken = response.refreshToken;
    _localStorageService.userData = response.user;
  }

  Future<AuthSuccessResponse?> login({
    required int type,
    String? emailAddress,
    String? mobile,
    required String password,
  }) async {
    try {
      if (type != LoginType.mobile.value && type != LoginType.email.value) {
        return null;
      }
      final [pushToken, deviceId] = await Future.wait([
        _getFirebaseToken(),
        _getDeviceId(),
      ]);
      final request = LoginRequest(
        type: type,
        email: type == LoginType.email.value ? emailAddress : null,
        mobile: type == LoginType.mobile.value ? mobile : null,
        password: password,
        pushToken: pushToken,
        deviceId: deviceId,
        deviceType: kIsWeb ? 'W' : 'M',
      );
      final responseData = await _apiClientService.userLogin(request);
      if (responseData.accessToken?.isNotEmpty ?? false) {
        _onUserAuthenticated(responseData);
      }
      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<bool> userLogout() async {
    try {
      await _apiClientService.userLogout({'deviceId': await _getDeviceId()});
      return true;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<ForgotPasswordResponse> forgotPassword({
    String? emailAddress,
    String? mobile,
    required int type,
  }) async {
    Map<String, dynamic> data = {};

    if (mobile != null) {
      data['mobile'] = mobile;
    }
    if (emailAddress != null) {
      data['email'] = emailAddress;
    }
    data['type'] = type;

    try {
      final responseData = await _apiClientService.forgotPassword(data);
      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<String> verifyForgotPasswordOtp({
    required String otpCode,
    required String token,
    required int verifyType,
    required int type,
    int? loginUserType,
  }) async {
    try {
      final responseData = await _apiClientService.verifyForgotPasswordOtp(
        VerifyOtpRequest(
          otp: otpCode,
          token: token,
          verifyType: verifyType,
          type: type,
          loginUserType: loginUserType,
        ),
      );
      return responseData.token;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<String> resendOtp({required String token, required int type}) async {
    try {
      final responseData = await _apiClientService.resendOtp(
        VerifyOtpRequest(preToken: token, type: type),
      );
      return responseData.token;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<bool> resetPassword({
    required String password,
    required String confirmPassword,
    required String token,
    required int type,
  }) async {
    try {
      await _apiClientService.resetPassword(
        ResetPasswordRequest(
          password: password,
          confirmPassword: confirmPassword,
          token: token,
          type: type,
        ),
      );
      return true;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  /// Step 1: Send OTP to user's current email or mobile before changing it.
  /// [type]: 1 = Mobile, 2 = Email
  Future<String> sendOtpToOldCredential({required int type}) async {
    try {
      final response = await _apiClientService.sendOtpToOldCredential(type);
      return response.token;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  /// Step 3: Submit the new email or mobile. Returns a token for step 4 (new cred OTP).
  /// [type]: 1 = Mobile, 2 = Email
  Future<String> changeCredential({
    required int type,
    required String token,
    String? mobile,
    String? email,
  }) async {
    try {
      final response = await _apiClientService.changeCredential(
        type: type,
        token: token,
        mobile: mobile,
        email: email,
      );
      return response.token;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }
}
