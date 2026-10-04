import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../localization/generated/l10n.dart';

enum OtpCodeInputError { required, invalidLength }

class OtpCodeInput extends FormzInput<String, OtpCodeInputError> {
  const OtpCodeInput.pure([String? initialValue]) : super.pure(initialValue ?? '');

  const OtpCodeInput.dirty(super.value) : super.dirty();

  @override
  OtpCodeInputError? validator(String value) {
    if (value.isEmpty) return OtpCodeInputError.required;
    if (value.length < 6) return OtpCodeInputError.invalidLength;
    return null;
  }
}

extension OtpCodeInputExtension on OtpCodeInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      OtpCodeInputError.required => AppLocalizations.current.errorOtpCodeRequired,
      OtpCodeInputError.invalidLength => AppLocalizations.current.errorOtpCodeInvalid,
    };
  }
}
