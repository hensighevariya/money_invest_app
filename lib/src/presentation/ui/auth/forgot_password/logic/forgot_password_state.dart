import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

class ForgotPasswordState extends Equatable with FormzMixin {
  const ForgotPasswordState({
    this.emailMobileInput = const EmailMobileInput.pure(),
    this.status = const ProgressStatus.initial(),
  });

  final EmailMobileInput emailMobileInput;
  final ProgressStatus<ForgotPasswordResponse> status;

  @override
  List<Object?> get props => [emailMobileInput, status];

  @override
  List<FormzInput<Object, Object?>> get inputs => [emailMobileInput];

  ForgotPasswordState copyWith({EmailMobileInput? emailMobileInput, ProgressStatus<ForgotPasswordResponse>? status}) {
    return ForgotPasswordState(
      emailMobileInput: emailMobileInput ?? this.emailMobileInput,
      status: status ?? this.status,
    );
  }
}
