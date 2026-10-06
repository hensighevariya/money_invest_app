import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/utils/constants.dart';
import 'package:money_invest_app/src/utils/validator.dart';

import '../../localization/generated/l10n.dart';

enum EmailMobileInputError { required, invalidMobileFormat, invalidEmailFormat }

/// Class for validating a form field that accepts either an email or a phone number.
class EmailMobileInput extends FormzInput<String, EmailMobileInputError>
    with EquatableMixin {
  final PhoneDetail? phoneDetail;

  const EmailMobileInput.pure([super.value = '', this.phoneDetail])
    : super.pure();

  const EmailMobileInput.dirty(super.value, this.phoneDetail) : super.dirty();

  @override
  EmailMobileInputError? validator(String value) {
    final phoneDetail = this.phoneDetail;
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return EmailMobileInputError.required;
    }

    if (phoneDetail != null && isOnlyDigit(trimmedValue)) {
      String phone = trimmedValue.replaceAll(' ', '');
      // Ignore leading 0 for length validation
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
      }
      if (phone.length < phoneDetail.minLength ||
          phone.length > phoneDetail.maxLength) {
        return EmailMobileInputError.invalidMobileFormat;
      }
      return null;
    }

    if (!AppConstants.emailPatternRegExp.hasMatch(trimmedValue)) {
      return EmailMobileInputError.invalidEmailFormat;
    }

    return null;
  }

  @override
  List<Object?> get props => [value, phoneDetail];
}

extension EmailMobileInputExtension on EmailMobileInputError {
  String getErrorMessage(BuildContext context) {
    return switch (this) {
      EmailMobileInputError.required =>
        AppLocalizations.current.errorEmailMobileRequired,
      EmailMobileInputError.invalidMobileFormat =>
        AppLocalizations.current.errorMobileInvalidFormat,
      EmailMobileInputError.invalidEmailFormat =>
        AppLocalizations.current.errorEmailAddressInvalidFormat,
    };
  }
}
