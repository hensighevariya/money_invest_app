import 'package:flutter/material.dart';

typedef RouteBuilder = Widget Function(BuildContext context, RouteState state);
typedef RedirectCheckCallback = RouteSettings? Function(RouteState state);
typedef CanNavigateCheckCallback = bool Function(RouteState state);

class RouteState {
  const RouteState({required this.uri, required this.arguments, required this.pathParams});

  final Uri uri;
  final Object? arguments;
  final Map<String, String> pathParams;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteState &&
          runtimeType == other.runtimeType &&
          uri == other.uri &&
          arguments == other.arguments &&
          pathParams == other.pathParams;

  @override
  int get hashCode => uri.hashCode ^ arguments.hashCode ^ pathParams.hashCode;
}

abstract class RouteInfo<T extends Object?> {
  RouteInfo({
    required this.routeName,
    required this.builder,
    this.redirect,
    this.canNavigate,
    this.paramPatterns = const {},
    this.authRequired = true,
  });

  final String routeName;
  final RouteBuilder builder;
  final RedirectCheckCallback? redirect;
  final CanNavigateCheckCallback? canNavigate;
  final Map<String, String> paramPatterns;
  final bool authRequired;

  static final RegExp paramNamePattern = RegExp(r':[A-Za-z0-9_]*');
  static const String defaultParamPattern = r'[A-Za-z0-9_-]{1,255}';
  static const String optionalPathSegmentPattern = r'(/[a-zA-Z0-9_-]*){0,}';

  bool hasMatch(String path) {
    String routeName = this.routeName;

    // replace path params with regex
    String routePattern = routeName.replaceAllMapped(paramNamePattern, (match) {
      String? paramName = match.group(0)?.substring(1) ?? '';
      return paramPatterns[paramName] ?? defaultParamPattern;
    });

    routePattern = '^$routePattern';
    if (routeName.endsWith('*')) {
      routePattern = '${routePattern.substring(0, routePattern.length - 1)}$optionalPathSegmentPattern';
    } else {
      routePattern = '$routePattern\$';
    }

    return RegExp(routePattern).hasMatch(path);
  }

  Route<T> buildRoute(RouteSettings settings, RouteState state);
}
