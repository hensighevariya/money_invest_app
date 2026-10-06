import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

class LoginState extends Equatable with FormzMixin {
  const LoginState({
    this.emailMobileInput = const EmailMobileInput.pure(),
    this.passwordInput = const UserPasswordInput.pure(),
    this.status = const ProgressStatus.initial(),
  });

  final EmailMobileInput emailMobileInput;
  final UserPasswordInput passwordInput;
  final ProgressStatus<UserData> status;

  @override
  List<Object?> get props => [emailMobileInput, passwordInput, status];

  @override
  List<FormzInput<Object, Object?>> get inputs => [
    emailMobileInput,
    passwordInput,
  ];

  LoginState copyWith({
    EmailMobileInput? emailMobileInput,
    UserPasswordInput? passwordInput,
    ProgressStatus<UserData>? status,
  }) {
    return LoginState(
      emailMobileInput: emailMobileInput ?? this.emailMobileInput,
      passwordInput: passwordInput ?? this.passwordInput,
      status: status ?? this.status,
    );
  }
}
