import 'dart:async';

import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

import 'reset_password_state.dart';

base class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  ResetPasswordCubit({
    required this._authRepository,
    required this._loadingHandler,
    required this.verificationToken,
    required this.type,
  }) : super(const ResetPasswordState());

  final String verificationToken;
  final int type;
  final AuthRepository _authRepository;
  final LoadingHandler _loadingHandler;

  void onPasswordChanged(String value) {
    emit(state.copyWith(passwordInput: PasswordInput.dirty(value)));
  }

  void onConfirmPasswordChanged(String value) {
    emit(
      state.copyWith(confirmPasswordInput: ConfirmPasswordInput.dirty(value)),
    );
  }

  Future<void> onContinue() async {
    if (state.isNotValid) return;

    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      final result = await processRequest(
        () => _authRepository.resetPassword(
          token: verificationToken,
          password: state.passwordInput.value,
          confirmPassword: state.confirmPasswordInput.value,
          type: type,
        ),
        loadingHandler: _loadingHandler.handleLoading,
      );
      if (result ?? false) {
        emit(state.copyWith(status: const ProgressStatus.success(true)));
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}
