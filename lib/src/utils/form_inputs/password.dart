import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../localization/generated/l10n.dart';
import '../constants.dart';

enum UserPasswordInputError { required }

class UserPasswordInput extends FormzInput<String, UserPasswordInputError> {
  const UserPasswordInput.pure([String? initialValue]) : super.pure(initialValue ?? '');

  const UserPasswordInput.dirty(super.value) : super.dirty();

  @override
  UserPasswordInputError? validator(String value) {
    if (value.isEmpty) return UserPasswordInputError.required;
    return null;
  }
}

enum PasswordInputError { required, invalidPattern }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure([String? initialValue]) : super.pure(initialValue ?? '');

  const PasswordInput.dirty(super.value) : super.dirty();

  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) return PasswordInputError.required;
    if (!AppConstants.passwordPatternRegExp.hasMatch(value)) return PasswordInputError.invalidPattern;
    return null;
  }
}

extension PasswordInputExtension on PasswordInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      PasswordInputError.required => AppLocalizations.current.errorPasswordRequired,
      PasswordInputError.invalidPattern => AppLocalizations.current.errorPasswordInvalidPattern,
    };
  }
}

enum ConfirmPasswordInputError { required, notMatch }

class ConfirmPasswordInput extends FormzInput<String, ConfirmPasswordInputError> {
  const ConfirmPasswordInput.pure([String? initialValue]) : super.pure(initialValue ?? '');

  const ConfirmPasswordInput.dirty(super.value) : super.dirty();

  @override
  ConfirmPasswordInputError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordInputError.required;
    return null;
  }

  ConfirmPasswordInputError? compare(String value) {
    if (this.value != value) return ConfirmPasswordInputError.notMatch;
    return null;
  }
}

extension ConfirmPasswordInputExtension on ConfirmPasswordInputError {
  String? getErrorMessage(BuildContext context) {
    return switch (this) {
      ConfirmPasswordInputError.required => AppLocalizations.current.errorConfirmPasswordRequired,
      ConfirmPasswordInputError.notMatch => AppLocalizations.current.errorConfirmPasswordNotMatch,
    };
  }
}
