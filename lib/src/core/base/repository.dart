import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:money_invest_app/src/utils/log.dart';

import 'exceptions.dart';

base class BaseRepository {
  @mustCallSuper
  void dispose() {}

  BaseException transformError(Object error, [StackTrace? stackTrace]) {
    Log.error(error);
    Log.error(stackTrace);
    switch (error) {
      case BaseException():
        return error;

      case DioException():
        if (error.error case BaseException exception) {
          return exception;
        }

        switch (error.type) {
          case DioExceptionType.connectionTimeout ||
              DioExceptionType.receiveTimeout ||
              DioExceptionType.sendTimeout ||
              DioExceptionType.transformTimeout:
            return const RequestTimeoutException();

          case DioExceptionType.badResponse:
            final statusCode = error.response?.statusCode;

            if (statusCode != null) {
              switch (statusCode) {
                case 401:
                  return const SessionExpiredException();
                case 403:
                  return const AccountInactiveError();

                case >= 400 && <= 499:
                  dynamic responseData = error.response?.data;
                  if (responseData is String && responseData.isNotEmpty) {
                    try {
                      responseData = jsonDecode(responseData);
                    } catch (_) {}
                  }
                  if (responseData is Map<String, dynamic>) {
                    final errorVal = responseData['error'];
                    final messageVal = responseData['message'];
                    final errorsVal = responseData['errors'];

                    final message = errorVal is String
                        ? errorVal
                        : (messageVal is String ? messageVal : null);

                    final errors = errorsVal is Map<String, dynamic>
                        ? errorsVal
                        : (errorVal is Map<String, dynamic> ? errorVal : null);

                    return InvalidResponseException(
                      statusCode: statusCode,
                      message: message,
                      errors: errors,
                    );
                  }
                case >= 500 && <= 599:
                  return const InternalServerException();
              }
            }
            break;

          case DioExceptionType.cancel:
            return const RequestCancelledException();

          case DioExceptionType.connectionError:
            return const NetworkConnectionException();

          case DioExceptionType.badCertificate:
            break;
          case DioExceptionType.unknown:
            if (error.error is HttpException || error.error is SocketException) {
              return const NetworkConnectionException();
            }
            break;
        }
      case HttpException():
      case SocketException():
        return const NetworkConnectionException();
    }
    return const RequestFailedException();
  }
}
