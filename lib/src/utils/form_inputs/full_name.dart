import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../localization/generated/l10n.dart';

enum UserFullNameInputError { required, invalidFormat }

class UserFullNameInput extends FormzInput<String, UserFullNameInputError> {
  const UserFullNameInput.pure([String? initialValue])
    : super.pure(initialValue ?? '');

  const UserFullNameInput.dirty(super.value) : super.dirty();

  static final _nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  @override
  UserFullNameInputError? validator(String value) {
    if (value.isEmpty) return UserFullNameInputError.required;
    if (!_nameRegex.hasMatch(value)) {
      return UserFullNameInputError.invalidFormat;
    }
    return null;
  }
}

extension UserFullNameInputExtension on UserFullNameInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      UserFullNameInputError.required =>
        AppLocalizations.current.errorFullNameRequired,
      UserFullNameInputError.invalidFormat =>
        AppLocalizations.current.errorFullNameInvalidFormat,
    };
  }
}
