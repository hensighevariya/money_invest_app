import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';

class ApiInterceptor extends QueuedInterceptorsWrapper {
  ApiInterceptor({
    required this.logEnabled,
    required this.localStorageService,
    required this.dioClient,
    required String encryptionKey,
    required String decryptionKey,
    required String encryptionIvKey,
    required String decryptionIvKey,
  }) : _encryption = AesEncryption.fromUtf8(
         key: encryptionKey,
         iv: encryptionIvKey,
       ),
       _decryption = AesEncryption.fromUtf8(
         key: decryptionKey,
         iv: decryptionIvKey,
       );

  final bool logEnabled;
  final LocalStorageService localStorageService;
  final Dio dioClient;
  final AesEncryption _encryption;
  final AesEncryption _decryption;

  static const _titleSeparator =
      '══════════════════════════════════════════════════';
  static const _encoder = JsonEncoder.withIndent('  ');

  void _printRequest(Object? value, [String prefix = '']) =>
      _print(value, prefix);

  void _printError(Object? value, [String prefix = '']) =>
      _print(value, prefix);

  void _printResponse(Object? value, [String prefix = '']) =>
      _print(value, prefix);

  void _print(Object? object, String prefix) {
    if (!logEnabled) return;

    String content;
    if (object is Map || object is List) {
      content = _encoder.convert(object);
    } else {
      content = object.toString();
    }
    if (prefix.isNotEmpty) content = '$prefix: $content';
    developer.log(content);
  }

  Object? _encryptRequestData(Object? requestData) {
    if (requestData is Iterable && requestData.isNotEmpty) {
      requestData = jsonEncode(requestData);
    }
    if (requestData is Map<String, dynamic> && requestData.isNotEmpty) {
      requestData = jsonEncode(requestData);
    }

    if (requestData is String && requestData.isNotEmpty) {
      var cipherData = _encryption.encrypt(requestData);
      requestData = cipherData.toJson();
      if (logEnabled) _printRequest(requestData, 'Encrypted Data');
    }
    return requestData;
  }

  Object? _decryptResponseData(Object? responseData) {
    if (responseData is String) responseData = jsonDecode(responseData);

    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('mac')) {
      try {
        String decrypted = _decryption.decrypt(
          CipherData.fromJson(responseData),
        );
        responseData = decrypted.isEmpty ? decrypted : jsonDecode(decrypted);
        if (logEnabled) _printResponse(responseData, 'Decrypted Data');
      } catch (_) {}
    }
    return responseData;
  }

  void _invalidateSession() {
    localStorageService.sessionToken = null;
    localStorageService.refreshSessionToken = null;
  }

  DioException _invalidSessionError(DioException err) {
    _invalidateSession();
    return err.copyWith(error: const InvalidSessionException());
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final LocalStorageService(:sessionToken) = localStorageService;
    options.headers['type'] = 1;
    options.headers['timezone'] = DateTime.now().timeZoneName;

    if (sessionToken?.isNotEmpty ?? false) {
      options.headers[io.HttpHeaders.authorizationHeader] =
          'Bearer $sessionToken';
    }
    options.headers['lang'] = localStorageService.languageCode ?? 'en';
    // options.headers['env'] = 'test';

    _printRequest('$_titleSeparator Request $_titleSeparator');
    _printRequest('[${options.method.toUpperCase()}] ${options.uri}');
    if (options.queryParameters.isNotEmpty) {
      _printRequest(options.queryParameters, 'QueryParameters');
    }
    _printRequest(options.headers, 'Headers');
    if (options.data is Map ||
        options.data is Iterable ||
        options.data is String) {
      _printRequest(options.data, 'Data');
    }

    if (options.contentType?.contains(Headers.jsonContentType) ?? false) {
      if (options.headers['env'] == 'test') {
        options.data = options.data;
      } else {
        options.data = _encryptRequestData(options.data);
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _printResponse('$_titleSeparator Response $_titleSeparator');
    _printResponse(
      '[${response.requestOptions.method.toUpperCase()}] [${response.statusCode}] ${response.requestOptions.uri}',
    );
    if (response.data is Map ||
        response.data is List ||
        response.data is String) {
      _printResponse(response.data, 'Data');
    }

    bool? hasJsonContentType = response.headers[Headers.contentTypeHeader]?.any(
      (element) => element.contains(Headers.jsonContentType),
    );
    if (hasJsonContentType ?? false) {
      response.data = _decryptResponseData(response.data);
    }

    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _printError('$_titleSeparator DioException $_titleSeparator');
    _printError(
      '[${err.requestOptions.method.toUpperCase()}] [${err.response?.statusCode}] ${err.requestOptions.uri}',
    );
    _printError('[${err.type}] ${err.message}');
    if (err.response?.data is Map ||
        err.response?.data is String ||
        err.response?.data is Iterable) {
      _printError(err.response?.data, 'Data');
    }

    if (err.response?.statusCode == 401) {
      final sessionToken = localStorageService.sessionToken;
      final requestToken = err
          .requestOptions
          .headers[io.HttpHeaders.authorizationHeader]
          ?.toString()
          .split(' ')
          .last;
      if (sessionToken == requestToken) {
        final refreshToken = localStorageService.refreshSessionToken;
        if (refreshToken == null || refreshToken.isEmpty) {
          return super.onError(_invalidSessionError(err), handler);
        }
        try {
          final data = await _refreshToken();
          localStorageService.sessionToken = data['accessToken'] as String;
          localStorageService.refreshSessionToken =
              data['refreshToken'] as String;
        } on DioException catch (error) {
          if (error.response?.statusCode case 401 || 409 || 404) {
            return super.onError(_invalidSessionError(err), handler);
          }
        } catch (_) {
          return super.onError(_invalidSessionError(err), handler);
        }
      }
    }

    super.onError(err, handler);
  }

  Future<dynamic> _refreshToken() async {
    final headers = {
      io.HttpHeaders.authorizationHeader:
          'Bearer ${localStorageService.refreshSessionToken}',
      io.HttpHeaders.acceptLanguageHeader:
          localStorageService.languageCode ?? 'en',
      io.HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      io.HttpHeaders.acceptHeader: Headers.jsonContentType,
    };
    final response = await dioClient.get<Map<String, dynamic>>(
      '/user/auth/refresh-token',
      options: Options(headers: headers),
    );
    dynamic responseData = _decryptResponseData(response.data);
    return responseData['data'];
  }
}
