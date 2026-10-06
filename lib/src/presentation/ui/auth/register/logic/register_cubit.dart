import 'package:country_picker/country_picker.dart';
import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';
import 'register_state.dart';

base class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  void onNameChanged(String value) {
    emit(state.copyWith(nameInput: UserFullNameInput.dirty(value)));
  }

  void onSurnameChanged(String value) {
    emit(state.copyWith(surnameInput: UserFullNameInput.dirty(value)));
  }

  void onEmailChanged(String value) {
    emit(state.copyWith(emailInput: EmailAddressInput.dirty(value)));
  }

  void onMobileChanged(String value, PhoneDetail phoneDetail) {
    emit(
      state.copyWith(mobileInput: EmailMobileInput.dirty(value, phoneDetail)),
    );
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(passwordInput: PasswordInput.dirty(value)));
  }

  void onConfirmPasswordChanged(String value) {
    emit(
      state.copyWith(confirmPasswordInput: ConfirmPasswordInput.dirty(value)),
    );
  }

  void onCountryChanged(String value) {
    emit(state.copyWith(country: value));
  }

  void onStateChanged(String value) {
    emit(state.copyWith(stateText: value));
  }

  void onCityChanged(String value) {
    emit(state.copyWith(city: value));
  }

  void onTermsAgreed(bool value) {
    emit(state.copyWith(agreedToTerms: value));
  }

  Future<void> onContinue() async {
    if (!state.isFormValid) return;
    // In real app, call repository here.
    emit(state.copyWith(status: const ProgressStatus.success(null)));
  }
}
