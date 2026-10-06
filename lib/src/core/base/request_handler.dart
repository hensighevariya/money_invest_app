import 'dart:async';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:money_invest_app/src/core/core.dart';

typedef RequestCallback<T> = FutureOr<T> Function();
typedef ErrorHandlerCallback =
    void Function(Object error, StackTrace? stackTrace);
typedef LoadingHandlerCallback = void Function(bool loading);

abstract mixin class RequestHandler {
  void handleError(Object error, StackTrace? stackTrace);

  @protected
  Future<T?> processRequest<T>(
    RequestCallback<T> request, {
    LoadingHandlerCallback? loadingHandler,
    ErrorHandlerCallback? errorHandler,
    bool throwOnError = false,
  }) async {
    T? result;
    try {
      loadingHandler?.call(true);
      // Retry when token expired and refresh token called
      result = await retry(
        request,
        delayFactor: Durations.short2,
        maxAttempts: 3,
        retryIf: (exception) =>
            exception is SessionExpiredException ||
            exception is NetworkConnectionException,
        maxDelay: Durations.medium2,
      );
    } catch (error, stackTrace) {
      if (throwOnError) {
        if (error is InvalidSessionException) handleError(error, null);
        rethrow;
      }

      if (errorHandler != null) {
        if (error is InvalidSessionException) handleError(error, null);
        errorHandler.call(error, stackTrace);
      } else {
        handleError(error, stackTrace);
      }
    } finally {
      loadingHandler?.call(false);
    }
    return result;
  }

  @protected
  Future<T?> processRequestWithRetry<T>(
    RequestCallback<T> request, {
    LoadingHandlerCallback? loadingHandler,
    ErrorHandlerCallback? errorHandler,
    bool throwOnError = false,
  }) async {
    return processRequest(
      () => retry(
        request,
        delayFactor: const Duration(milliseconds: 100),
        maxAttempts: 3,
        maxDelay: const Duration(milliseconds: 500),
      ),
      loadingHandler: loadingHandler,
      errorHandler: errorHandler,
      throwOnError: throwOnError,
    );
  }
}
