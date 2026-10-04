import 'package:flutter/material.dart';

import 'generated/l10n.dart';

export 'generated/l10n.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);
}
