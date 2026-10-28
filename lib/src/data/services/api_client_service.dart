import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/log.dart';
import 'network/request/user.dart';

List<T> _parseList<T>(
  dynamic value,
  T Function(Map<String, dynamic> json) parser,
) {
  if (value is String && value.isNotEmpty) {
    try {
      value = jsonDecode(value);
    } catch (error) {
      Log.error('_parseList => $error');
    }
  }
  if (value is Map<String, dynamic>) {
    if (value.containsKey('data') && value['data'] is Iterable) {
      value = value['data'];
    } else if (value.containsKey('countries') &&
        value['countries'] is Iterable) {
      value = value['countries'];
    } else if (value.containsKey('states') && value['states'] is Iterable) {
      value = value['states'];
    } else if (value.containsKey('cities') && value['cities'] is Iterable) {
      value = value['cities'];
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

  FutureOr<T> _parseResponseData<T>(
    Response<dynamic> response,
    T Function(dynamic responseData) parser,
  ) {
    return compute((message) {
      final dynamic raw = message is Map<String, dynamic> &&
              message.containsKey('data') &&
              message['data'] != null
          ? message['data']
          : message;
      return parser(raw);
    }, response.data);
  }

  //region ---------------------------------------- Auth ----------------------------------------

  Future<RegisterResponse> userRegister(RegisterRequest request) async {
    final response = await _dioClient.post<dynamic>(
      '/api/auth/register',
      data: request.toJson(),
    );
    return _parseResponseData(
      response,
      (responseData) {
        if (responseData is Map<String, dynamic>) {
          return RegisterResponse.fromJson(responseData);
        }
        return const RegisterResponse();
      },
    );
  }

  Future<AuthSuccessResponse> userLogin({
    required String email,
    required String password,
    required String pushToken,
    required Map<String, String> deviceHeaders,
  }) async {
    final response = await _dioClient.post<dynamic>(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
        'pushToken': pushToken,
      },
      options: Options(headers: deviceHeaders),
    );
    final rawData = response.data;
    if (rawData is Map<String, dynamic> && rawData['success'] == false) {
      throw InvalidResponseException(
        statusCode: response.statusCode ?? 200,
        message: rawData['message'] as String? ?? 'Failed to login',
        errors: rawData['errors'] is Map<String, dynamic>
            ? rawData['errors'] as Map<String, dynamic>
            : null,
      );
    }
    return _parseResponseData(
      response,
      (responseData) {
        if (responseData is Map<String, dynamic> &&
            response.data is Map<String, dynamic>) {
          final resMap = response.data as Map<String, dynamic>;
          if (resMap.containsKey('message') &&
              !responseData.containsKey('message')) {
            return AuthSuccessResponse.fromJson({
              ...responseData,
              'message': resMap['message'],
            });
          }
        }
        return AuthSuccessResponse.fromJson(
          responseData as Map<String, dynamic>,
        );
      },
    );
  }

  Future<void> userLogout() async {
    final response = await _dioClient.patch<dynamic>(
      '/api/auth/logout',
      options: Options(
        headers: {
          'Accept-Language': 'en',
        },
      ),
    );
    final rawData = response.data;
    if (rawData is Map<String, dynamic> && rawData['success'] == false) {
      throw InvalidResponseException(
        statusCode: response.statusCode ?? 200,
        message: rawData['message'] as String? ?? 'Failed to logout',
        errors: rawData['errors'] is Map<String, dynamic>
            ? rawData['errors'] as Map<String, dynamic>
            : null,
      );
    }
  }

  /// 1. Forgot Password: POST /api/auth/forgot-password
  Future<ForgotPasswordResponse> forgotPassword(dynamic request) async {
    final Map<String, dynamic> data = request is Map<String, dynamic>
        ? request
        : {'identifier': request.toString()};
    final response = await _dioClient.post<dynamic>(
      '/api/auth/forgot-password',
      data: data,
    );
    return _parseResponseData(response, (responseData) {
      return ForgotPasswordResponse.fromData(responseData);
    });
  }

  /// 2. Verify OTP: POST /api/auth/forgot-password/verify-otp
  Future<ForgotPasswordVerifyResponse> verifyForgotPasswordOtp({
    required String token,
    required String otp,
    required String type,
  }) async {
    final response = await _dioClient.post<dynamic>(
      '/api/auth/forgot-password/verify-otp',
      data: {
        'token': token,
        'otp': otp,
        'type': type,
      },
    );
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromData(responseData),
    );
  }

  /// 3. Resend OTP: POST /api/auth/forgot-password/resend-otp
  Future<ForgotPasswordVerifyResponse> resendForgotPasswordOtp({
    required String token,
    required String type,
  }) async {
    final response = await _dioClient.post<dynamic>(
      '/api/auth/forgot-password/resend-otp',
      data: {
        'token': token,
        'type': type,
      },
    );
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromData(responseData),
    );
  }

  Future<ForgotPasswordVerifyResponse> resendOtp(
    VerifyOtpRequest request,
  ) async {
    return resendForgotPasswordOtp(
      token: request.token ?? request.preToken ?? '',
      type: request.type == 1 ? 'mobile' : 'email',
    );
  }

  /// 4. Reset Password: POST /api/auth/reset-password
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _dioClient.post<dynamic>(
      '/api/auth/reset-password',
      data: request.toJson(),
    );
  }

  /// Send OTP to old (current) credential before changing it.
  /// [type]: 1 = Mobile, 2 = Email
  Future<ForgotPasswordVerifyResponse> sendOtpToOldCredential(int type) async {
    final response = await _dioClient.post<dynamic>(
      '/user/send-otp-old-cred',
      data: {'type': type},
    );
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromJson(
        responseData as Map<String, dynamic>,
      ),
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
    final response = await _dioClient.post<dynamic>(
      '/user/change-credential',
      data: data,
    );
    return _parseResponseData(
      response,
      (responseData) => ForgotPasswordVerifyResponse.fromJson(
        responseData as Map<String, dynamic>,
      ),
    );
  }

  //endregion ---------------------------------------- Auth ----------------------------------------

  //region ---------------------------------------- User ----------------------------------------

  Future<UserData> getUserProfile() async {
    final response = await _dioClient.get<dynamic>(
      '/api/auth/me',
    );
    final rawData = response.data;
    if (rawData is Map<String, dynamic> && rawData['success'] == false) {
      throw InvalidResponseException(
        statusCode: response.statusCode ?? 200,
        message: rawData['message'] as String? ?? 'Failed to get profile',
        errors: rawData['errors'] is Map<String, dynamic>
            ? rawData['errors'] as Map<String, dynamic>
            : null,
      );
    }
    return _parseResponseData(
      response,
      (responseData) {
        if (responseData is Map<String, dynamic>) {
          return UserData.fromJson(responseData);
        }
        return const UserData(id: '');
      },
    );
  }

  Future<void> updateUserProfile(UpdateProfileRequest request) async {
    await _dioClient.put<dynamic>(
      '/user/auth/edit-user-profile',
      data: request.toJson(),
    );
  }

  Future<void> changeUserPassword(ChangePasswordRequest request) async {
    await _dioClient.post<dynamic>(
      '/user/auth/change-password',
      data: request.toJson(),
    );
  }

  //endregion ---------------------------------------- User ----------------------------------------

  // region ---------------------------------------- Common ----------------------------------------

  Future<AppVersionData> getVersionData(String platform) async {
    final response = await _dioClient.get<dynamic>(
      '/user/auth/get-version',
      queryParameters: {'platform': platform},
    );
    return _parseResponseData(
      response,
      (responseData) =>
          AppVersionData.fromJson(responseData as Map<String, dynamic>),
    );
  }

  //endregion ---------------------------------------- Common ----------------------------------------

  //region ---------------------------------------- Locations ----------------------------------------

  Future<List<LocationCountry>> getCountries() async {
    final response = await _dioClient.get<dynamic>('/api/locations/countries');
    return compute(
      (dynamic message) =>
          _parseList<LocationCountry>(message, LocationCountry.fromJson),
      response.data,
    );
  }

  Future<List<LocationState>> getStates(String countryId) async {
    final response = await _dioClient.get<dynamic>(
      '/api/locations/states',
      queryParameters: {'countryId': countryId},
    );
    return compute(
      (dynamic message) =>
          _parseList<LocationState>(message, LocationState.fromJson),
      response.data,
    );
  }

  Future<List<LocationCity>> getCities({
    required String countryId,
    required String stateId,
  }) async {
    final response = await _dioClient.get<dynamic>(
      '/api/locations/cities',
      queryParameters: {'countryId': countryId, 'stateId': stateId},
    );
    return compute(
      (dynamic message) =>
          _parseList<LocationCity>(message, LocationCity.fromJson),
      response.data,
    );
  }

  //endregion ---------------------------------------- Locations ----------------------------------------

  //region ---------------------------------------- Registration OTP ----------------------------------------
  Future<VerifyOtpData> verifyRegistrationOtp({
    required String token,
    required String otp,
    required String type,
    required Map<String, String> deviceHeaders,
  }) async {
    final response = await _dioClient.post<dynamic>(
      '/api/auth/verify-otp',
      data: {
        'token': token,
        'otp': otp,
        'type': type,
      },
      options: Options(headers: deviceHeaders),
    );
    final rawData = response.data;
    if (rawData is Map<String, dynamic> && rawData['success'] == false) {
      throw InvalidResponseException(
        statusCode: response.statusCode ?? 200,
        message: rawData['message'] as String? ?? 'Invalid or expired OTP',
        errors: rawData['errors'] is Map<String, dynamic>
            ? rawData['errors'] as Map<String, dynamic>
            : null,
      );
    }
    return _parseResponseData(response, (responseData) {
      final msg = response.data is Map<String, dynamic>
          ? (response.data as Map)['message'] as String?
          : null;
      if (responseData is Map<String, dynamic>) {
        final payload = {
          ...responseData,
          if (msg != null && !responseData.containsKey('message'))
            'message': msg,
        };
        return VerifyOtpData.fromJson(payload);
      }
      return VerifyOtpData(message: msg);
    });
  }

  Future<dynamic> resendRegistrationOtp({
    required String token,
    required String type,
  }) async {
    final response = await _dioClient.post<dynamic>(
      '/api/auth/resend-otp',
      data: {
        'token': token,
        'type': type,
      },
    );
    final rawData = response.data;
    if (rawData is Map<String, dynamic> && rawData['success'] == false) {
      throw InvalidResponseException(
        statusCode: response.statusCode ?? 200,
        message: rawData['message'] as String? ?? 'Failed to resend OTP',
        errors: rawData['errors'] is Map<String, dynamic>
            ? rawData['errors'] as Map<String, dynamic>
            : null,
      );
    }
    return _parseResponseData(response, (responseData) {
      if (responseData is Map<String, dynamic> &&
          response.data is Map<String, dynamic>) {
        final resMap = response.data as Map<String, dynamic>;
        if (resMap.containsKey('message') &&
            !responseData.containsKey('message')) {
          return {
            ...responseData,
            'message': resMap['message'],
          };
        }
      } else if (response.data is Map<String, dynamic>) {
        return response.data;
      }
      return responseData;
    });
  }
  //endregion ---------------------------------------- Registration OTP ----------------------------------------
}

