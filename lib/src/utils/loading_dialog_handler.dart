import 'package:flutter/material.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';

class LoadingDialogHandler extends LoadingHandler {
  LoadingDialogHandler({required this._context});

  final BuildContext _context;
  Route<void>? _dialogRoute;

  Widget _buildDialog(BuildContext context) {
    return const PopScope(canPop: false, child: Center(child: LoadingIndicator()));
  }

  Route<void> _buildDialogRoute() {
    return RawDialogRoute(
      barrierDismissible: false,
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        Widget dialog = SafeArea(child: Builder(builder: _buildDialog));

        return dialog;
      },
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut), child: child);
      },
    );
  }

  @override
  void handleLoading(bool loading) {
    if (loading) {
      if (_dialogRoute != null) return;
      _dialogRoute = _buildDialogRoute();
      Navigator.maybeOf(_context)?.push(_dialogRoute!);
    } else {
      if (_dialogRoute != null) Navigator.maybeOf(_context)?.removeRoute(_dialogRoute!);
      _dialogRoute = null;
    }
  }
}
