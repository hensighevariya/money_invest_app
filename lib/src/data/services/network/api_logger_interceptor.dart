import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A logger interceptor that formats and logs:
/// - Full URL (Method + complete resolved URI + query params)
/// - Request headers & request body
/// - Response status code, full URL, response headers, and response body
/// - Detailed errors and execution duration
class ApiLoggerInterceptor extends Interceptor {
  ApiLoggerInterceptor({
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = _defaultPrint,
    this.enabled = kDebugMode,
  });

  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool error;
  final bool enabled;
  final void Function(String message) logPrint;

  static const String _startTimeKey = '_api_logger_start_time';
  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  static void _defaultPrint(String message) {
    // Print line by line to avoid terminal truncation of large payloads
    debugPrint(message);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;
      _logRequest(options);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (enabled) {
      _logResponse(response);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled && error) {
      _logError(err);
    }
    super.onError(err, handler);
  }

  void _logRequest(RequestOptions options) {
    final buffer = StringBuffer();
    final fullUrl = options.uri.toString();
    final method = options.method.toUpperCase();

    buffer.writeln('┌─────────────────────────── [API REQUEST] ───────────────────────────');
    buffer.writeln('│ 🌐 Method & Full URL: $method $fullUrl');

    // Query parameters
    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('│ 🔍 Query Parameters:');
      buffer.writeln(_indentString(_formatJson(options.queryParameters)));
    }

    // Headers
    if (requestHeader && options.headers.isNotEmpty) {
      buffer.writeln('│ 📋 Request Headers:');
      buffer.writeln(_indentString(_formatJson(options.headers)));
    }

    // Request Body
    if (requestBody && options.data != null) {
      buffer.writeln('│ 📦 Request Body:');
      buffer.writeln(_indentString(_formatData(options.data)));
    }

    buffer.write('└─────────────────────────────────────────────────────────────────────');
    _printBuffer(buffer);
  }

  void _logResponse(Response<dynamic> response) {
    final buffer = StringBuffer();
    final fullUrl = response.requestOptions.uri.toString();
    final method = response.requestOptions.method.toUpperCase();
    final statusCode = response.statusCode ?? 0;
    final statusMessage = response.statusMessage ?? '';
    final duration = _calculateDuration(response.requestOptions);

    buffer.writeln('┌─────────────────────────── [API RESPONSE] ──────────────────────────');
    buffer.writeln('│ ✅ [$statusCode $statusMessage] in $duration ms: $method $fullUrl');

    // Response Headers
    if (responseHeader && response.headers.map.isNotEmpty) {
      buffer.writeln('│ 📋 Response Headers:');
      buffer.writeln(_indentString(_formatJson(response.headers.map)));
    }

    // Response Body
    if (responseBody && response.data != null) {
      buffer.writeln('│ 📦 Response Body:');
      buffer.writeln(_indentString(_formatData(response.data)));
    }

    buffer.write('└─────────────────────────────────────────────────────────────────────');
    _printBuffer(buffer);
  }

  void _logError(DioException err) {
    final buffer = StringBuffer();
    final fullUrl = err.requestOptions.uri.toString();
    final method = err.requestOptions.method.toUpperCase();
    final statusCode = err.response?.statusCode ?? 0;
    final statusMessage = err.response?.statusMessage ?? err.type.name;
    final duration = _calculateDuration(err.requestOptions);

    buffer.writeln('┌──────────────────────────── [API ERROR] ────────────────────────────');
    buffer.writeln('│ ❌ [$statusCode $statusMessage] in $duration ms: $method $fullUrl');
    buffer.writeln('│ ⚠️ Error Type: ${err.type}');
    if (err.message != null && err.message!.isNotEmpty) {
      buffer.writeln('│ 💬 Error Message: ${err.message}');
    }

    // Response Headers on Error
    if (responseHeader && err.response?.headers.map.isNotEmpty == true) {
      buffer.writeln('│ 📋 Response Headers:');
      buffer.writeln(_indentString(_formatJson(err.response!.headers.map)));
    }

    // Error Body
    if (err.response?.data != null) {
      buffer.writeln('│ 📦 Error Response Body:');
      buffer.writeln(_indentString(_formatData(err.response!.data)));
    }

    buffer.write('└─────────────────────────────────────────────────────────────────────');
    _printBuffer(buffer);
  }

  int _calculateDuration(RequestOptions options) {
    final startTime = options.extra[_startTimeKey];
    if (startTime is int) {
      return DateTime.now().millisecondsSinceEpoch - startTime;
    }
    return 0;
  }

  String _formatData(dynamic data) {
    if (data == null) return 'null';
    if (data is FormData) {
      final fields = data.fields.map((e) => '${e.key}: ${e.value}').toList();
      final files = data.files.map((e) => '${e.key}: ${e.value.filename}').toList();
      return _encoder.convert({'fields': fields, 'files': files});
    }
    if (data is Map || data is List) {
      return _formatJson(data);
    }
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        return _encoder.convert(decoded);
      } catch (_) {
        return data;
      }
    }
    return data.toString();
  }

  String _formatJson(dynamic json) {
    try {
      return _encoder.convert(json);
    } catch (_) {
      return json.toString();
    }
  }

  String _indentString(String text) {
    return text.split('\n').map((line) => '│   $line').join('\n');
  }

  void _printBuffer(StringBuffer buffer) {
    logPrint(buffer.toString());
  }
}
