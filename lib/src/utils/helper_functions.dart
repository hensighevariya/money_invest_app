import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_invest_app/src/core/base/exceptions.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';

String generateUserIdentifier() {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = math.Random.secure();
  String datePart = DateTime.timestamp().millisecondsSinceEpoch.toRadixString(
    36,
  );
  String randomPart = chars[(random.nextDouble() * chars.length).floor()];
  return '$datePart$randomPart'.toUpperCase();
}

void copyToClipboard(BuildContext context, String data) {
  Clipboard.setData(ClipboardData(text: data)).then((value) {
    if (context.mounted) {
      showSuccessMessage(
        context: context,
        content: context.localizations.copiedToClipboardHint,
      );
    }
  });
}

String formatErrorMessage(Object error, AppLocalizations l10n) {
  return switch (error) {
    NetworkConnectionException() => l10n.internetErrorDescription,
    InternalServerException() => l10n.serverErrorDescription,
    RequestTimeoutException() => l10n.timeoutErrorMessage,
    AccountInactiveError() =>
      'Your account is currently inactive. Please contact support to reactivate your account or for further assistance',
    InvalidResponseException(:final message, :final errors) => () {
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
          if (errorValues.length == 1) return errorValues.first;
          if (errorValues.length > 1) {
            return errorValues.map((e) => '• $e').join('\n');
          }
        }
        return (message != null && message.isNotEmpty)
            ? message
            : l10n.unknownErrorTitle;
      }(),
    RequestProcessingException(:final message) => message,
    RequestFailedException() => l10n.unknownErrorDescription,
    String() => error,
    _ => l10n.unknownErrorDescription,
  };
}
