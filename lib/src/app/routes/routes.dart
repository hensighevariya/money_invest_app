import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/presentation/presentation.dart';
import 'package:money_invest_app/src/presentation/ui/auth/register/register_screen.dart';
import 'package:money_invest_app/src/presentation/ui/auth/register/register_otp_screen.dart';
import 'package:money_invest_app/src/presentation/ui/home/home_screen.dart';
import 'package:money_invest_app/src/presentation/ui/profile/profile_screen.dart';

extension BuildContextExtension on BuildContext {
  String get currentPath => GoRouterState.of(this).uri.path;
}

class AppRoutes with ChangeNotifier {
  AppRoutes({required this.navigatorKey, this._userAuthorized = false})
    : _hasForceUpdate = false,
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
    return '/login';
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
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                path: 'register',
                builder: (context, state) => const RegisterScreen(),
                routes: [
                  GoRoute(
                    path: 'register-verify-otp',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>? ?? {};
                      return RegisterOtpScreen(
                        mobile: extra['mobile'] as String? ?? '',
                        email: extra['email'] as String? ?? '',
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'forgot-password',
                builder: (context, state) => const ForgotPasswordScreen(),
                routes: [
                  GoRoute(
                    path: 'verify-otp',
                    builder: (context, state) => const OtpVerificationScreen(),
                    routes: [GoRoute(path: 'reset-password', builder: (context, state) => const ResetPasswordScreen())],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
