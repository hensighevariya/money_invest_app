import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../localization/generated/l10n.dart';

enum UserFullNameInputError { required }

class UserFullNameInput extends FormzInput<String, UserFullNameInputError> {
  const UserFullNameInput.pure([String? initialValue]) : super.pure(initialValue ?? '');

  const UserFullNameInput.dirty(super.value) : super.dirty();

  @override
  UserFullNameInputError? validator(String value) {
    if (value.isEmpty) return UserFullNameInputError.required;
    return null;
  }
}

extension UserFullNameInputExtension on UserFullNameInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      UserFullNameInputError.required => AppLocalizations.current.errorFullNameRequired,
    };
  }
}
