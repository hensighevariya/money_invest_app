import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

class RegisterState extends Equatable with FormzMixin {
  const RegisterState({
    this.nameInput = const UserFullNameInput.pure(),
    this.surnameInput = const UserFullNameInput.pure(),
    this.emailInput = const EmailAddressInput.pure(),
    this.mobileInput = const EmailMobileInput.pure(),
    this.passwordInput = const PasswordInput.pure(),
    this.confirmPasswordInput = const ConfirmPasswordInput.pure(),
    this.selectedCountry,
    this.countries = const [],
    this.isLoadingCountries = false,
    this.selectedState,
    this.states = const [],
    this.isLoadingStates = false,
    this.selectedCity,
    this.cities = const [],
    this.isLoadingCities = false,
    this.addressInput = const AddressInput.pure(),
    this.pincodeInput = const PincodeInput.pure(),
    this.agreedToTerms = false,
    this.status = const ProgressStatus.initial(),
  });

  final UserFullNameInput nameInput;
  final UserFullNameInput surnameInput;
  final EmailAddressInput emailInput;
  final EmailMobileInput mobileInput;
  final PasswordInput passwordInput;
  final ConfirmPasswordInput confirmPasswordInput;

  final LocationCountry? selectedCountry;
  final List<LocationCountry> countries;
  final bool isLoadingCountries;

  final LocationState? selectedState;
  final List<LocationState> states;
  final bool isLoadingStates;

  final LocationCity? selectedCity;
  final List<LocationCity> cities;
  final bool isLoadingCities;

  final AddressInput addressInput;
  final PincodeInput pincodeInput;

  final bool agreedToTerms;
  final ProgressStatus<dynamic> status;

  @override
  List<Object?> get props => [
    nameInput,
    surnameInput,
    emailInput,
    mobileInput,
    passwordInput,
    confirmPasswordInput,
    selectedCountry,
    countries,
    isLoadingCountries,
    selectedState,
    states,
    isLoadingStates,
    selectedCity,
    cities,
    isLoadingCities,
    addressInput,
    pincodeInput,
    agreedToTerms,
    status,
  ];

  @override
  List<FormzInput<Object, Object?>> get inputs => [
    nameInput,
    surnameInput,
    emailInput,
    mobileInput,
    passwordInput,
    confirmPasswordInput,
    addressInput,
    pincodeInput,
  ];

  bool get isFormValid =>
      Formz.validate(inputs) &&
      agreedToTerms &&
      passwordInput.value.isNotEmpty &&
      passwordInput.value == confirmPasswordInput.value &&
      selectedCountry != null &&
      selectedState != null &&
      (cities.isEmpty || selectedCity != null);

  RegisterState copyWith({
    UserFullNameInput? nameInput,
    UserFullNameInput? surnameInput,
    EmailAddressInput? emailInput,
    EmailMobileInput? mobileInput,
    PasswordInput? passwordInput,
    ConfirmPasswordInput? confirmPasswordInput,
    LocationCountry? Function()? selectedCountry,
    List<LocationCountry>? countries,
    bool? isLoadingCountries,
    LocationState? Function()? selectedState,
    List<LocationState>? states,
    bool? isLoadingStates,
    LocationCity? Function()? selectedCity,
    List<LocationCity>? cities,
    bool? isLoadingCities,
    AddressInput? addressInput,
    PincodeInput? pincodeInput,
    bool? agreedToTerms,
    ProgressStatus<dynamic>? status,
  }) {
    return RegisterState(
      nameInput: nameInput ?? this.nameInput,
      surnameInput: surnameInput ?? this.surnameInput,
      emailInput: emailInput ?? this.emailInput,
      mobileInput: mobileInput ?? this.mobileInput,
      passwordInput: passwordInput ?? this.passwordInput,
      confirmPasswordInput: confirmPasswordInput ?? this.confirmPasswordInput,
      selectedCountry:
          selectedCountry != null ? selectedCountry() : this.selectedCountry,
      countries: countries ?? this.countries,
      isLoadingCountries: isLoadingCountries ?? this.isLoadingCountries,
      selectedState:
          selectedState != null ? selectedState() : this.selectedState,
      states: states ?? this.states,
      isLoadingStates: isLoadingStates ?? this.isLoadingStates,
      selectedCity: selectedCity != null ? selectedCity() : this.selectedCity,
      cities: cities ?? this.cities,
      isLoadingCities: isLoadingCities ?? this.isLoadingCities,
      addressInput: addressInput ?? this.addressInput,
      pincodeInput: pincodeInput ?? this.pincodeInput,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
      status: status ?? this.status,
    );
  }
}
