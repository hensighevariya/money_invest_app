import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_invest_app/src/core/base/exceptions.dart';
import 'package:money_invest_app/src/presentation/components/alert_message.dart';

import '../localization/generated/l10n.dart';
import '../presentation/presentation.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;
  bool logEnabled = false;

  void _log(String value) {
    if (kDebugMode && logEnabled) {
      developer.log(value);
    }
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _log('onCreate: ${bloc.runtimeType} { state: ${bloc.state} }');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _log('onEvent: ${bloc.runtimeType} { event: $event }');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _log(
      'onTransition: ${bloc.runtimeType} { event: ${transition.event}, currentState: ${transition.currentState}, nextState: ${transition.nextState} }',
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _log(
      'onChange: ${bloc.runtimeType} { currentState: ${change.currentState}, nextState: ${change.nextState} }',
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _log('onClose: ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _log(
      'onError: ${bloc.runtimeType} { error: $error, stackTrace:$stackTrace }',
    );

    if (error is BaseException) {
      _handleApiRequestException(error);
    }
  }

  void _handleApiRequestException(BaseException error) {
    // Show errors with overlay context
    final context = navigatorKey.currentContext;
    final localizations = AppLocalizations.current;

    final overlayContext =
        navigatorKey.currentState?.overlay?.context ?? context;
    if (overlayContext == null) return;

    // Check that context contains material widget to properly show error widgets.
    debugCheckHasMaterialLocalizations(overlayContext);

    switch (error) {
      case NetworkConnectionException():
        showErrorMessage(
          context: overlayContext,
          content: localizations.internetErrorDescription,
        );
        break;
      case InternalServerException():
        showErrorMessage(
          context: overlayContext,
          content: localizations.serverErrorDescription,
        );
        break;
      case RequestTimeoutException():
        showErrorMessage(
          context: overlayContext,
          content: localizations.timeoutErrorMessage,
        );
        break;
      case SessionExpiredException():
        break;
      case InvalidSessionException():
        context?.read<UserProfileBloc>().add(const UserLoggedOut());
        break;
      case AccountInactiveError():
        showErrorMessage(
          context: overlayContext,
          content:
              'Your account is currently inactive. Please contact support to reactivate your account or for further assistance',
        );
        context?.read<UserProfileBloc>().add(const UserLoggedOut());
        break;
      case ResponseDecryptionException():
        break;
      case InvalidResponseException(
        errors: Map<String, dynamic>? errors,
        message: String? message,
      ):
        if (errors != null && errors.isNotEmpty) {
          final errorValues = <String>[];
          for (final val in errors.values) {
            if (val == null) continue;
            if (val is Iterable) {
              for (final item in val) {
                final str = item.toString().trim();
                if (str.isNotEmpty) errorValues.add(str);
              }
            } else {
              final str = val.toString().trim();
              if (str.isNotEmpty) errorValues.add(str);
            }
          }

          if (errorValues.length == 1) {
            showErrorMessage(
              context: overlayContext,
              content: errorValues.first,
            );
          } else if (errorValues.length > 1) {
            final formattedError = errorValues.map((e) => '• $e').join('\n');
            showErrorMessage(
              context: overlayContext,
              content: formattedError,
            );
          } else if (message != null && message.isNotEmpty) {
            showErrorMessage(context: overlayContext, content: message);
          } else {
            showErrorMessage(
              context: overlayContext,
              content: localizations.unknownErrorTitle,
            );
          }
        } else if (message != null && message.isNotEmpty) {
          showErrorMessage(context: overlayContext, content: message);
        } else {
          showErrorMessage(
            context: overlayContext,
            content: localizations.unknownErrorTitle,
          );
        }
        break;
      case RequestFailedException():
        showErrorMessage(
          context: overlayContext,
          content: localizations.unknownErrorDescription,
        );
        break;
      case RequestCancelledException():
        break;
      case RequestProcessingException():
        showErrorMessage(context: overlayContext, content: error.message);
    }
  }
}
