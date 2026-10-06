import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
