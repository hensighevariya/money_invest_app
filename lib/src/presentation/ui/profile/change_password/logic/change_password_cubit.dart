import 'dart:async';

import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

import 'change_password_state.dart';

base class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordCubit({
    required UserRepository userRepository,
    required LoadingHandler loadingHandler,
  })  : _userRepository = userRepository,
        _loadingHandler = loadingHandler,
        super(const ChangePasswordState());

  final UserRepository _userRepository;
  final LoadingHandler _loadingHandler;

  void onCurrentPasswordChanged(String value) {
    emit(state.copyWith(currentPasswordInput: UserPasswordInput.dirty(value)));
  }

  void onNewPasswordChanged(String value) {
    emit(state.copyWith(newPasswordInput: PasswordInput.dirty(value)));
  }

  void onConfirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPasswordInput: ConfirmPasswordInput.dirty(value),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      final result = await processRequest(
        () => _userRepository.changePassword(
          currentPassword: state.currentPasswordInput.value,
          newPassword: state.newPasswordInput.value,
          confirmPassword: state.confirmPasswordInput.value,
        ),
        loadingHandler: _loadingHandler.handleLoading,
        throwOnError: true,
      );
      if (result ?? false) {
        emit(state.copyWith(status: const ProgressStatus.success(true)));
      } else {
        emit(state.copyWith(status: const ProgressStatus.initial()));
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}

