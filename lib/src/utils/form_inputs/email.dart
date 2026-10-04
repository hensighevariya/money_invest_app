import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../localization/generated/l10n.dart';
import '../constants.dart';

enum EmailAddressInputError { required, invalidFormat }

class EmailAddressInput extends FormzInput<String, EmailAddressInputError> {
  const EmailAddressInput.pure([String? initialValue]) : super.pure(initialValue ?? '');

  const EmailAddressInput.dirty(super.value) : super.dirty();

  @override
  EmailAddressInputError? validator(String value) {
    if (value.isEmpty) return EmailAddressInputError.required;
    if (!AppConstants.emailPatternRegExp.hasMatch(value)) return EmailAddressInputError.invalidFormat;
    return null;
  }
}

extension EmailAddressInputExtension on EmailAddressInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      EmailAddressInputError.required => AppLocalizations.current.errorEmailAddressRequired,
      EmailAddressInputError.invalidFormat => AppLocalizations.current.errorEmailAddressInvalidFormat,
    };
  }
}
