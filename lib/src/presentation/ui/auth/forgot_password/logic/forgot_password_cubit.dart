import 'package:country_picker/country_picker.dart';
import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';
import 'package:money_invest_app/src/utils/validator.dart';
import 'forgot_password_state.dart';

base class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required this._authRepository,
    required this._loadingHandler,
  }) : super(const ForgotPasswordState());

  final AuthRepository _authRepository;
  final LoadingHandler _loadingHandler;

  void onEmailAddressChanged(String value, PhoneDetail phoneDetail) {
    emit(
      state.copyWith(
        emailMobileInput: EmailMobileInput.dirty(value, phoneDetail),
      ),
    );
  }

  Future<void> onContinue() async {
    if (state.isNotValid) return;

    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      final result = await processRequest(
        () => _authRepository.forgotPassword(
          emailAddress: (!isOnlyDigit(state.emailMobileInput.value))
              ? state.emailMobileInput.value
              : null,
          mobile: isOnlyDigit(state.emailMobileInput.value)
              ? '+${state.emailMobileInput.phoneDetail?.code} ${state.emailMobileInput.value}'
              : null,
          type: (isOnlyDigit(state.emailMobileInput.value)) ? 1 : 2,
        ),
        loadingHandler: _loadingHandler.handleLoading,
      );

      if (result != null) {
        emit(state.copyWith(status: ProgressStatus.success(result)));
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}
