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

  Future<void> userLogout() async {
    await _dioClient.put<dynamic>('/user/auth/log-out');
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
