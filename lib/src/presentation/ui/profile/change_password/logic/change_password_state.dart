import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

class ChangePasswordState extends Equatable with FormzMixin {
  const ChangePasswordState({
    this.currentPasswordInput = const UserPasswordInput.pure(),
    this.newPasswordInput = const PasswordInput.pure(),
    this.confirmPasswordInput = const ConfirmPasswordInput.pure(),
    this.status = const ProgressStatus.initial(),
  });

  final UserPasswordInput currentPasswordInput;
  final PasswordInput newPasswordInput;
  final ConfirmPasswordInput confirmPasswordInput;
  final ProgressStatus<bool> status;

  @override
  List<Object?> get props => [
    currentPasswordInput,
    newPasswordInput,
    confirmPasswordInput,
    status,
  ];

  @override
  List<FormzInput<Object, Object?>> get inputs => [
    currentPasswordInput,
    newPasswordInput,
    confirmPasswordInput,
  ];

  bool get isPasswordsMatch =>
      confirmPasswordInput.value == newPasswordInput.value;

  bool get isCurrentDifferentFromNew =>
      currentPasswordInput.value.isEmpty ||
      currentPasswordInput.value != newPasswordInput.value;

  bool get canSubmit =>
      isValid && isPasswordsMatch && isCurrentDifferentFromNew;

  ChangePasswordState copyWith({
    UserPasswordInput? currentPasswordInput,
    PasswordInput? newPasswordInput,
    ConfirmPasswordInput? confirmPasswordInput,
    ProgressStatus<bool>? status,
  }) {
    return ChangePasswordState(
      currentPasswordInput:
          currentPasswordInput ?? this.currentPasswordInput,
      newPasswordInput: newPasswordInput ?? this.newPasswordInput,
      confirmPasswordInput:
          confirmPasswordInput ?? this.confirmPasswordInput,
      status: status ?? this.status,
    );
  }
}

