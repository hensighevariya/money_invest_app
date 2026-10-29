import 'package:country_picker/country_picker.dart';
import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

import 'login_state.dart';

base class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit({
    required this._authRepository,
    required UserRepository userRepository,
    required this._loadingHandler,
  }) : super(const LoginState());

  final AuthRepository _authRepository;
  final LoadingHandler _loadingHandler;

  void onEmailAddressChanged(String value, PhoneDetail phoneDetail) {
    emit(
      state.copyWith(
        emailMobileInput: EmailMobileInput.dirty(value, phoneDetail),
      ),
    );
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(passwordInput: UserPasswordInput.dirty(value)));
  }

  Future<void> onContinue() async {
    if (state.isNotValid) {
      emit(
        state.copyWith(
          emailMobileInput: EmailMobileInput.dirty(
            state.emailMobileInput.value,
            state.emailMobileInput.phoneDetail,
          ),
          passwordInput: UserPasswordInput.dirty(state.passwordInput.value),
        ),
      );
      return;
    }
    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      final result = await processRequest(
        () async {
          final email = state.emailMobileInput.value.trim();
          final password = state.passwordInput.value;
          final authResponse = await _authRepository.login(
            email: email,
            password: password,
          );

          return authResponse?.user;
        },
        loadingHandler: _loadingHandler.handleLoading,
        throwOnError: true,
      );

      if (result == null) return;

      emit(state.copyWith(status: ProgressStatus.success(result)));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}
