import 'package:country_picker/country_picker.dart';
import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/enum.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';
import 'package:money_invest_app/src/utils/validator.dart';

import 'login_state.dart';

base class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit({required this._authRepository, required this._userRepository, required this._loadingHandler})
    : super(const LoginState());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final LoadingHandler _loadingHandler;

  void onEmailAddressChanged(String value, PhoneDetail phoneDetail) {
    emit(state.copyWith(emailMobileInput: EmailMobileInput.dirty(value, phoneDetail)));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(passwordInput: UserPasswordInput.dirty(value)));
  }

  Future<UserData?> _resolveLoggedInUser(AuthSuccessResponse? authResponse) async {
    if (authResponse == null) return null;

    final loginUser = authResponse.user;

    await _userRepository.getProfile();
    final profileUser = _userRepository.getCurrentUser();

    if (profileUser == null) {
      return loginUser;
    }

    return profileUser;
  }

  Future<void> onContinue() async {
    if (state.isNotValid) return;
    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      final result = await processRequest(() async {
        final mobile = isOnlyDigit(state.emailMobileInput.value.trim());
        final authResponse = mobile
            ? await _authRepository.login(
                type: LoginType.mobile.value,
                mobile: '+${state.emailMobileInput.phoneDetail?.code} ${state.emailMobileInput.value}',
                password: state.passwordInput.value,
                emailAddress: '',
              )
            : await _authRepository.login(
                type: LoginType.email.value,
                emailAddress: state.emailMobileInput.value.trim(),
                password: state.passwordInput.value,
              );

        return _resolveLoggedInUser(authResponse);
      }, loadingHandler: _loadingHandler.handleLoading);

      if (result == null) return;

      emit(state.copyWith(status: ProgressStatus.success(result)));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}
