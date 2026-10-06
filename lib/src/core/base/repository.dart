import 'dart:io';

import 'package:common_extensions/common_extensions.dart';
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
              DioExceptionType.sendTimeout:
            return const RequestTimeoutException();

          case DioExceptionType.badResponse:
            final statusCode = error.response?.statusCode;

            if (statusCode != null) {
              switch (statusCode) {
                case 401:
                  return const SessionExpiredException();

                case >= 400 && <= 499:
                  final responseData = error.response?.data;
                  if (responseData is Map<String, dynamic>) {
                    return InvalidResponseException(
                      statusCode: statusCode,
                      message: (responseData['message'] as Object?)?.also(
                        (message) => message is String ? message : null,
                      ),
                      errors: (responseData['errors'] as Object?)?.also(
                        (errors) =>
                            errors is Map<String, dynamic> ? errors : null,
                      ),
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
            if (error.error is HttpException ||
                error.error is SocketException) {
              return const NetworkConnectionException();
            }
            break;
          case DioExceptionType.transformTimeout:
            // TODO: Handle this case.
            throw UnimplementedError();
        }
      case HttpException():
      case SocketException():
        return const NetworkConnectionException();
    }
    return const RequestFailedException();
  }
}
