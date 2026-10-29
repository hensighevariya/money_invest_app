import 'package:country_picker/country_picker.dart';
import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';
import 'register_state.dart';

base class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit({required this._authRepository, required this._loadingHandler}) : super(const RegisterState());

  final AuthRepository _authRepository;
  final LoadingHandler _loadingHandler;

  Future<void> loadCountries() async {
    emit(state.copyWith(isLoadingCountries: true));
    try {
      final countries = await _authRepository.getCountries();
      LocationCountry? defaultCountry = state.selectedCountry;
      if (defaultCountry == null && countries.isNotEmpty) {
        try {
          defaultCountry = countries.firstWhere(
            (c) =>
                c.name.trim().toLowerCase() == 'india' ||
                c.isoCode?.trim().toUpperCase() == 'IN' ||
                c.phoneCode?.trim().replaceAll('+', '') == '91',
          );
        } catch (_) {
          defaultCountry = countries.first;
        }
      }

      emit(
        state.copyWith(
          countries: countries,
          selectedCountry: defaultCountry != null ? () => defaultCountry : null,
          isLoadingCountries: false,
        ),
      );

      if (defaultCountry != null) {
        await _loadStates(defaultCountry.id);
      }
    } catch (e) {
      emit(state.copyWith(countries: const [], isLoadingCountries: false));
    }
  }

  Future<void> _loadStates(String countryId) async {
    emit(state.copyWith(isLoadingStates: true));
    try {
      final states = await _authRepository.getStates(countryId);
      emit(state.copyWith(states: states, isLoadingStates: false));
    } catch (e) {
      emit(state.copyWith(states: const [], isLoadingStates: false));
    }
  }

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
    emit(state.copyWith(mobileInput: EmailMobileInput.dirty(value, phoneDetail)));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(passwordInput: PasswordInput.dirty(value)));
  }

  void onConfirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPasswordInput: ConfirmPasswordInput.dirty(value)));
  }

  Future<void> onCountrySelected(LocationCountry? country) async {
    if (country == state.selectedCountry) return;
    emit(
      state.copyWith(
        selectedCountry: () => country,
        selectedState: () => null,
        selectedCity: () => null,
        states: const [],
        cities: const [],
      ),
    );
    if (country != null) {
      await _loadStates(country.id);
    }
  }

  Future<void> onCountryIdSelected(String? countryId) async {
    if (countryId == null) {
      emit(
        state.copyWith(
          selectedCountry: () => null,
          selectedState: () => null,
          selectedCity: () => null,
          states: const [],
          cities: const [],
        ),
      );
      return;
    }
    final country = state.countries.firstWhere(
      (c) => c.id == countryId,
      orElse: () => LocationCountry(id: countryId, name: countryId),
    );
    await onCountrySelected(country);
  }

  Future<void> onStateSelected(LocationState? stateModel) async {
    if (stateModel == state.selectedState) return;
    emit(state.copyWith(selectedState: () => stateModel, selectedCity: () => null, cities: const []));
    if (stateModel != null && state.selectedCountry != null) {
      emit(state.copyWith(isLoadingCities: true));
      try {
        final cities = await _authRepository.getCities(countryId: state.selectedCountry!.id, stateId: stateModel.id);
        emit(state.copyWith(cities: cities, isLoadingCities: false));
      } catch (e) {
        emit(state.copyWith(cities: const [], isLoadingCities: false));
      }
    }
  }

  Future<void> onStateIdSelected(String? stateId) async {
    if (stateId == null) {
      emit(state.copyWith(selectedState: () => null, selectedCity: () => null, cities: const []));
      return;
    }
    final stateModel = state.states.firstWhere(
      (s) => s.id == stateId,
      orElse: () => LocationState(id: stateId, name: stateId),
    );
    await onStateSelected(stateModel);
  }

  void onCitySelected(LocationCity? city) {
    emit(state.copyWith(selectedCity: () => city));
  }

  void onCityIdSelected(String? cityId) {
    if (cityId == null) {
      emit(state.copyWith(selectedCity: () => null));
      return;
    }
    final cityModel = state.cities.firstWhere(
      (c) => c.id == cityId,
      orElse: () => LocationCity(id: cityId, name: cityId),
    );
    onCitySelected(cityModel);
  }

  void onAddressChanged(String value) {
    emit(state.copyWith(addressInput: AddressInput.dirty(value)));
  }

  void onPincodeChanged(String value) {
    emit(state.copyWith(pincodeInput: PincodeInput.dirty(value)));
  }

  void onTermsAgreed(bool value) {
    emit(state.copyWith(agreedToTerms: value));
  }

  Future<void> onContinue() async {
    if (!state.isFormValid) {
      emit(
        state.copyWith(
          nameInput: UserFullNameInput.dirty(state.nameInput.value),
          surnameInput: UserFullNameInput.dirty(state.surnameInput.value),
          emailInput: EmailAddressInput.dirty(state.emailInput.value),
          mobileInput: EmailMobileInput.dirty(
            state.mobileInput.value,
            state.mobileInput.phoneDetail ?? const (code: '91', minLength: 10, maxLength: 10),
          ),
          passwordInput: PasswordInput.dirty(state.passwordInput.value),
          confirmPasswordInput: ConfirmPasswordInput.dirty(state.confirmPasswordInput.value),
          addressInput: AddressInput.dirty(state.addressInput.value),
          pincodeInput: PincodeInput.dirty(state.pincodeInput.value),
        ),
      );
      return;
    }

    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      final result = await processRequest(
        () async {
          final phoneCode = state.mobileInput.phoneDetail?.code ?? '91';
          final rawPhone = state.mobileInput.value.trim().replaceAll(' ', '');
          final fullPhone = rawPhone.startsWith('+') ? rawPhone : '+$phoneCode$rawPhone';

          return await _authRepository.register(
            firstName: state.nameInput.value.trim(),
            lastName: state.surnameInput.value.trim(),
            email: state.emailInput.value.trim(),
            phoneNumber: fullPhone,
            password: state.passwordInput.value,
            confirmPassword: state.confirmPasswordInput.value,
            countryId: state.selectedCountry?.id,
            stateId: state.selectedState!.id,
            cityId: state.selectedCity?.id ?? '',
            address: state.addressInput.value.trim(),
            pincode: state.pincodeInput.value.trim(),
          );
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
