import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      return webInfo.userAgent ?? 'web_browser';
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? iosInfo.modelName;
    } else if (Platform.isMacOS) {
      final macInfo = await deviceInfoPlugin.macOsInfo;
      return macInfo.systemGUID ?? 'mac_device';
    } else {
      return 'device_${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  Future<Map<String, String>> _getDeviceHeaders() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId = 'device_mac_001';
    String deviceName = 'Chrome on MacOS';
    String deviceType = 'web';
    String version = '1.0.0';

    try {
      final packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
    } catch (_) {}

    try {
      if (kIsWeb) {
        final webInfo = await deviceInfoPlugin.webBrowserInfo;
        deviceId = webInfo.userAgent ?? 'web_browser';
        deviceName = '${webInfo.browserName.name} on ${webInfo.platform}';
        deviceType = 'web';
      } else if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceName = '${androidInfo.manufacturer} ${androidInfo.model}';
        deviceType = 'android';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? iosInfo.model;
        deviceName = iosInfo.name;
        deviceType = 'ios';
      } else if (Platform.isMacOS) {
        final macInfo = await deviceInfoPlugin.macOsInfo;
        deviceId = macInfo.systemGUID ?? 'device_mac_001';
        deviceName = macInfo.computerName;
        deviceType = 'mac';
      }
    } catch (_) {}

    return {
      'x-device-id': deviceId,
      'x-device-name': deviceName,
      'x-device-type': deviceType,
      'x-version': version,
    };
  }

  void _onUserAuthenticated(AuthSuccessResponse response) {
    _localStorageService.sessionToken = response.accessToken ?? response.token;
    _localStorageService.refreshSessionToken = response.refreshToken;
    _localStorageService.userData = response.user;
  }

  Future<AuthSuccessResponse?> login({
    required String email,
    required String password,
  }) async {
    try {
      final pushToken = await _getFirebaseToken() ?? '';
      final deviceHeaders = await _getDeviceHeaders();

      final responseData = await _apiClientService.userLogin(
        email: email,
        password: password,
        pushToken: pushToken,
        deviceHeaders: deviceHeaders,
      );

      if ((responseData.accessToken?.isNotEmpty ?? false) ||
          (responseData.token?.isNotEmpty ?? false)) {
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

  Future<List<LocationCountry>> getCountries() async {
    try {
      return await _apiClientService.getCountries();
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<List<LocationState>> getStates(String countryId) async {
    try {
      return await _apiClientService.getStates(countryId);
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<List<LocationCity>> getCities({
    required String countryId,
    required String stateId,
  }) async {
    try {
      return await _apiClientService.getCities(
        countryId: countryId,
        stateId: stateId,
      );
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<RegisterResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String stateId,
    required String cityId,
    required String address,
    required String pincode,
  }) async {
    try {
      final pushToken = /*await _getFirebaseToken() ??*/ '';
      final request = RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        stateId: stateId,
        cityId: cityId,
        address: address,
        pincode: pincode,
        pushToken: pushToken,
      );
      final responseData = await _apiClientService.userRegister(request);
      if (responseData.accessToken?.isNotEmpty ?? false) {
        _onUserAuthenticated(
          AuthSuccessResponse(
            accessToken: responseData.accessToken,
            refreshToken: responseData.refreshToken,
            user: responseData.user,
          ),
        );
      }
      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<VerifyOtpData> verifyRegistrationOtp({
    required String token,
    required String otp,
    required String type,
  }) async {
    try {
      final headers = await _getDeviceHeaders();
      final responseData = await _apiClientService.verifyRegistrationOtp(
        token: token,
        otp: otp,
        type: type,
        deviceHeaders: headers,
      );

      final accessToken = responseData.token;
      final refreshToken = responseData.refreshToken;
      if (accessToken != null && accessToken.isNotEmpty) {
        _onUserAuthenticated(
          AuthSuccessResponse(
            accessToken: accessToken,
            refreshToken: refreshToken,
            user: responseData.user,
          ),
        );
      }

      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<dynamic> resendRegistrationOtp({
    required String token,
    required String type,
  }) async {
    try {
      return await _apiClientService.resendRegistrationOtp(
        token: token,
        type: type,
      );
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }
}
