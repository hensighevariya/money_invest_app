import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

class ResetPasswordState extends Equatable with FormzMixin {
  const ResetPasswordState({
    this.passwordInput = const PasswordInput.pure(),
    this.confirmPasswordInput = const ConfirmPasswordInput.pure(),
    this.status = const ProgressStatus.initial(),
  });

  final PasswordInput passwordInput;
  final ConfirmPasswordInput confirmPasswordInput;
  final ProgressStatus<bool> status;

  @override
  List<Object?> get props => [passwordInput, confirmPasswordInput, status];

  @override
  List<FormzInput<Object, Object?>> get inputs => [
    passwordInput,
    confirmPasswordInput,
  ];

  ResetPasswordState copyWith({
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
    ProgressStatus<bool>? status,
  }) {
    return ResetPasswordState(
      passwordInput: passwordInput ?? this.passwordInput,
      confirmPasswordInput: confirmPasswordInput ?? this.confirmPasswordInput,
      status: status ?? this.status,
    );
  }
}
