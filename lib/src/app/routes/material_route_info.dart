import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'route_info.dart';

class MaterialRouteInfo<T extends Object?> extends RouteInfo<T> {
  MaterialRouteInfo({
    required super.routeName,
    required super.builder,
    super.canNavigate,
    super.paramPatterns,
    super.redirect,
    super.authRequired = true,
    this.fullScreenDialog = false,
    this.allowSnapshotting = true,
    this.barrierDismissible = false,
    this.maintainState = true,
  });

  final bool fullScreenDialog;
  final bool allowSnapshotting;
  final bool barrierDismissible;
  final bool maintainState;

  @override
  Route<T> buildRoute(RouteSettings settings, RouteState state) {
    if (kIsWeb) {
      return _FadePageRoute<T>(
        builder: (context) => builder(context, state),
        settings: settings,
        fullscreenDialog: fullScreenDialog,
        allowSnapshotting: allowSnapshotting,
        barrierDismissible: barrierDismissible,
        maintainState: maintainState,
      );
    }
    return MaterialPageRoute<T>(
      builder: (context) => builder(context, state),
      settings: settings,
      fullscreenDialog: fullScreenDialog,
      allowSnapshotting: allowSnapshotting,
      barrierDismissible: barrierDismissible,
      maintainState: maintainState,
    );
  }
}

class _FadePageRoute<T> extends PageRouteBuilder<T> {
  _FadePageRoute({
    required WidgetBuilder builder,
    super.settings,
    super.fullscreenDialog,
    super.allowSnapshotting,
    super.barrierDismissible,
    super.maintainState,
  }) : super(
         transitionDuration: const Duration(milliseconds: 200),
         reverseTransitionDuration: const Duration(milliseconds: 200),
         pageBuilder: (context, animation, secondaryAnimation) {
           final result = builder(context);
           return Semantics(scopesRoute: true, explicitChildNodes: true, child: result);
         },
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return FadeTransition(opacity: animation, child: child);
         },
       );
}
