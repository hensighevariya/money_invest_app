import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

class RegisterState extends Equatable with FormzMixin {
  const RegisterState({
    this.nameInput = const UserFullNameInput.pure(),
    this.surnameInput = const UserFullNameInput.pure(),
    this.emailInput = const EmailAddressInput.pure(),
    this.mobileInput = const EmailMobileInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
    this.confirmPasswordInput = const ConfirmPasswordInput.pure(),
    this.country = '',
    this.stateText = '',
    this.city = '',
    this.agreedToTerms = false,
    this.status = const ProgressStatus.initial(),
  });

  final UserFullNameInput nameInput;
  final UserFullNameInput surnameInput;
  final EmailAddressInput emailInput;
  final EmailMobileInput mobileInput;
  final PasswordInput passwordInput;
  final ConfirmPasswordInput confirmPasswordInput;

  final String country;
  final String stateText;
  final String city;
  final bool agreedToTerms;

  final ProgressStatus<void> status;

  @override
  List<Object?> get props => [
    nameInput,
    surnameInput,
    emailInput,
    mobileInput,
    passwordInput,
    confirmPasswordInput,
    country,
    stateText,
    city,
    agreedToTerms,
    status,
  ];

  @override
  List<FormzInput<Object, Object?>> get inputs => [
    nameInput,
    surnameInput,
    emailInput,
    mobileInput,
    passwordInput,
    confirmPasswordInput,
  ];

  // To handle confirm password matching properly:
  bool get isFormValid =>
      Formz.validate(inputs) &&
      agreedToTerms &&
      passwordInput.value == confirmPasswordInput.value &&
      country.isNotEmpty &&
      stateText.isNotEmpty &&
      city.isNotEmpty;

  RegisterState copyWith({
    UserFullNameInput? nameInput,
    UserFullNameInput? surnameInput,
    EmailAddressInput? emailInput,
    EmailMobileInput? mobileInput,
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
    String? country,
    String? stateText,
    String? city,
    bool? agreedToTerms,
    ProgressStatus<void>? status,
  }) {
    return RegisterState(
      nameInput: nameInput ?? this.nameInput,
      surnameInput: surnameInput ?? this.surnameInput,
      emailInput: emailInput ?? this.emailInput,
      mobileInput: mobileInput ?? this.mobileInput,
      passwordInput: passwordInput ?? this.passwordInput,
      confirmPasswordInput: confirmPasswordInput ?? this.confirmPasswordInput,
      country: country ?? this.country,
      stateText: stateText ?? this.stateText,
      city: city ?? this.city,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      status: status ?? this.status,
    );
  }
}
