import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/localization/localization.dart';

enum PincodeInputError { required }

class PincodeInput extends FormzInput<String, PincodeInputError> {
  const PincodeInput.pure([String? initialValue])
      : super.pure(initialValue ?? '');

  const PincodeInput.dirty(super.value) : super.dirty();

  @override
  PincodeInputError? validator(String value) {
    if (value.trim().isEmpty) return PincodeInputError.required;
    return null;
  }
}

extension PincodeInputExtension on PincodeInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      PincodeInputError.required =>
        context.localizations.errorPincodeRequired,
    };
  }
}
