import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/presentation/presentation.dart';

class AppRoutes with ChangeNotifier {
  AppRoutes({required this.navigatorKey, bool userAuthorized = false})
    : _userAuthorized = userAuthorized,
      _hasForceUpdate = false,
      _isUnderMaintenance = false;

  final GlobalKey<NavigatorState> navigatorKey;
  bool _userAuthorized;

  set userAuthorized(bool value) {
    _userAuthorized = value;
    notifyListeners();
  }

  bool _hasForceUpdate;

  set hasForceUpdate(bool value) {
    _hasForceUpdate = value;
    notifyListeners();
  }

  bool _isUnderMaintenance;

  set isUnderMaintenance(bool value) {
    _isUnderMaintenance = value;
    notifyListeners();
  }

  RouterConfig<Object> get routerConfig => _goRouter;

  FutureOr<String?> _checkAuthRedirect(BuildContext context, GoRouterState state) {
    if (_userAuthorized) return '/';
    return null;
  }

  String? _checkUserAuthorized(BuildContext context, GoRouterState state) {
    if (_userAuthorized) return null;
    return '/auth';
  }

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: this,
    redirect: (context, state) {
      if (_hasForceUpdate) return '/force-update';
      if (_isUnderMaintenance) return '/maintenance';
      return null;
    },
    initialLocation: '/intro',
    routes: [
      GoRoute(path: '/intro', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/auth', builder: (context, state) => const LoginScreen()),
    ],
  );
}
