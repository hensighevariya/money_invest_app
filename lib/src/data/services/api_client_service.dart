import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/log.dart';
import 'network/request/user.dart';

List<T> _parseList<T>(dynamic value, T Function(Map<String, dynamic> json) parser) {
  if (value is String && value.isNotEmpty) {
    try {
      value = jsonDecode(value);
    } catch (error) {
      Log.error('_parseList => $error');
    }
  }
  if (value is! Iterable) return [];

  final List<T> list = <T>[];
  for (final element in value) {
    try {
      list.add(parser(element as Map<String, dynamic>));
    } catch (error, stackTrace) {
      Log.error('_parseList => $error');
      Log.error('_parseList => $stackTrace');
    }
  }
  return list;
}

class ApiClientService {
  ApiClientService(this._dioClient);

  final Dio _dioClient;

  FutureOr<T> _parseResponseData<T>(Response<dynamic> response, T Function(dynamic responseData) parser) {
    return compute((message) => parser(message['data']), response.data);
  }

  //region ---------------------------------------- Auth ----------------------------------------

  Future<AuthSuccessResponse> userLogin(LoginRequest request) async {
    final response = await _dioClient.post<dynamic>('/user/auth/sign-in', data: request.toJson());
    return _parseResponseData(
      response,
      (responseData) => AuthSuccessResponse.fromJson(responseData as Map<String, dynamic>),
    );
  }

  Future<void> userLogout(Map<String, dynamic> request) async {
    await _dioClient.patch<dynamic>('/user/auth/log-out', queryParameters: request);
  }

  ///forgot-password
  Future<ForgotPasswordResponse> forgotPassword(Map<String, dynamic> request) async {
    final response = await _dioClient.post<dynamic>('/user/auth/forgot-password', data: request);
    return _parseResponseData(response, (responseData) {
      return ForgotPasswordResponse.fromJson(responseData as Map<String, dynamic>);
    });
  }

  ///forgot-verify-otp
  Future<ForgotPasswordVerifyResponse> verifyForgotPasswordOtp(VerifyOtpRequest request) async {
    final response = await _dioClient.post<dynamic>('/user/auth/verify-otp', data: request.toJson());
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromJson(responseData as Map<String, dynamic>),
    );
  }

  Future<ForgotPasswordVerifyResponse> resendOtp(VerifyOtpRequest request) async {
    final response = await _dioClient.post<dynamic>('/user/auth/resend-otp', data: request.toJson());
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromJson(responseData as Map<String, dynamic>),
    );
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _dioClient.post<dynamic>('/user/auth/reset-password', data: request.toJson());
  }

  /// Send OTP to old (current) credential before changing it.
  /// [type]: 1 = Mobile, 2 = Email
  Future<ForgotPasswordVerifyResponse> sendOtpToOldCredential(int type) async {
    final response = await _dioClient.post<dynamic>('/user/send-otp-old-cred', data: {'type': type});
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromJson(responseData as Map<String, dynamic>),
    );
  }

  /// Change credential (email or mobile) after old-cred OTP is verified.
  /// [type]: 1 = Mobile, 2 = Email
  Future<ForgotPasswordVerifyResponse> changeCredential({
    required int type,
    required String token,
    String? mobile,
    String? email,
  }) async {
    final Map<String, dynamic> data = {'type': type, 'token': token};
    if (mobile != null) data['mobile'] = mobile;
    if (email != null) data['email'] = email;
    final response = await _dioClient.post<dynamic>('/user/change-credential', data: data);
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromJson(responseData as Map<String, dynamic>),
    );
  }

  //endregion ---------------------------------------- Auth ----------------------------------------

  //region ---------------------------------------- User ----------------------------------------

  Future<UserData> getUserProfile() async {
    final response = await _dioClient.get<dynamic>('/user/auth/get-user-profile');
    return _parseResponseData(response, (responseData) => UserData.fromJson(responseData as Map<String, dynamic>));
  }

  Future<void> updateUserProfile(UpdateProfileRequest request) async {
    await _dioClient.put<dynamic>('/user/auth/edit-user-profile', data: request.toJson());
  }

  Future<void> changeUserPassword(ChangePasswordRequest request) async {
    await _dioClient.post<dynamic>('/user/auth/change-password', data: request.toJson());
  }

  //endregion ---------------------------------------- User ----------------------------------------

  // region ---------------------------------------- Common ----------------------------------------

  Future<AppVersionData> getVersionData(String platform) async {
    final response = await _dioClient.get<dynamic>('/user/auth/get-version', queryParameters: {'platform': platform});
    return _parseResponseData(
      response,
      (responseData) => AppVersionData.fromJson(responseData as Map<String, dynamic>),
    );
  }

  //endregion ---------------------------------------- Common ----------------------------------------
}
