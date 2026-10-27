import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/localization/localization.dart';

enum AddressInputError { required }

class AddressInput extends FormzInput<String, AddressInputError> {
  const AddressInput.pure([String? initialValue])
      : super.pure(initialValue ?? '');

  const AddressInput.dirty(super.value) : super.dirty();

  @override
  AddressInputError? validator(String value) {
    if (value.trim().isEmpty) return AddressInputError.required;
    return null;
  }
}

extension AddressInputExtension on AddressInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      AddressInputError.required =>
        context.localizations.errorAddressRequired,
    };
  }
}
