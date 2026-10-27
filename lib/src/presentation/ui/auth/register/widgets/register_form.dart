import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_invest_app/src/data/model/location_model.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/components/location_picker_bottom_sheet.dart';
import 'package:money_invest_app/src/presentation/components/mobile_number_field.dart';
import 'package:money_invest_app/src/presentation/resources/assets.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

import '../logic/register_cubit.dart';
import '../logic/register_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _countryController;
  late final TextEditingController _stateController;
  late final TextEditingController _cityController;
  late final TextEditingController _emailController;
  late final MobileNumberController _mobileNumberController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _addressController;
  late final TextEditingController _pincodeController;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    final state = context.read<RegisterCubit>().state;
    _nameController = TextEditingController(text: state.nameInput.value);
    _surnameController = TextEditingController(text: state.surnameInput.value);
    _countryController = TextEditingController(text: state.selectedCountry?.name ?? '');
    _stateController = TextEditingController(text: state.selectedState?.name ?? '');
    _cityController = TextEditingController(text: state.selectedCity?.name ?? '');
    _emailController = TextEditingController(text: state.emailInput.value);
    _mobileNumberController = MobileNumberController(text: state.mobileInput.value);
    _passwordController = TextEditingController(text: state.passwordInput.value);
    _confirmPasswordController = TextEditingController(text: state.confirmPasswordInput.value);
    _addressController = TextEditingController(text: state.addressInput.value);
    _pincodeController = TextEditingController(text: state.pincodeInput.value);
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          previous.selectedCountry != current.selectedCountry ||
          previous.selectedState != current.selectedState ||
          previous.selectedCity != current.selectedCity,
      listener: (context, state) {
        if (_countryController.text != (state.selectedCountry?.name ?? '')) {
          _countryController.text = state.selectedCountry?.name ?? '';
        }
        if (_stateController.text != (state.selectedState?.name ?? '')) {
          _stateController.text = state.selectedState?.name ?? '';
        }
        if (_cityController.text != (state.selectedCity?.name ?? '')) {
          _cityController.text = state.selectedCity?.name ?? '';
        }
      },
      child: Column(
        spacing: Spacing.xLarge,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            spacing: Spacing.normal,
            children: [
              // First Name
              InputFieldDecoration(
                labelText: localizations.registerNameHint,
                child: BlocSelector<RegisterCubit, RegisterState, UserFullNameInput>(
                  selector: (state) => state.nameInput,
                  builder: (context, nameInput) {
                    return CommonTextField(
                      controller: _nameController,
                      hintText: localizations.registerNameHint,
                      errorText: nameInput.displayError?.getErrorMessage(context),
                      onChanged: (value) => context.read<RegisterCubit>().onNameChanged(value),
                      prefixIcon: SvgImageFromAsset.square(
                        SvgIcons.icnPerson,
                        size: 22,
                        color: context.colorScheme.onSurface,
                      ),
                    );
                  },
                ),
              ),

              // Last Name / Surname
              InputFieldDecoration(
                labelText: localizations.registerSurnameHint,
                child: BlocSelector<RegisterCubit, RegisterState, UserFullNameInput>(
                  selector: (state) => state.surnameInput,
                  builder: (context, surnameInput) {
                    return CommonTextField(
                      controller: _surnameController,
                      hintText: localizations.registerSurnameHint,
                      errorText: surnameInput.displayError?.getErrorMessage(context),
                      onChanged: (value) => context.read<RegisterCubit>().onSurnameChanged(value),
                      prefixIcon: SvgImageFromAsset.square(
                        SvgIcons.icnPerson,
                        size: 22,
                        color: context.colorScheme.onSurface,
                      ),
                    );
                  },
                ),
              ),

              // Country Picker
              InputFieldDecoration(
                labelText: localizations.registerCountryHint,
                isRequired: true,
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.countries != current.countries ||
                      previous.selectedCountry != current.selectedCountry ||
                      previous.isLoadingCountries != current.isLoadingCountries,
                  builder: (context, state) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: state.isLoadingCountries
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              if (state.countries.isEmpty) {
                                await context.read<RegisterCubit>().loadCountries();
                              }
                              if (!context.mounted) return;
                              final selected = await LocationPickerBottomSheet.show<LocationCountry>(
                                context: context,
                                title: localizations.registerCountryHint,
                                searchHint: localizations.searchCountry,
                                items: state.countries,
                                itemLabel: (country) => country.name,
                                itemId: (country) => country.id,
                                selectedId: state.selectedCountry?.id,
                              );
                              if (selected != null && context.mounted) {
                                context.read<RegisterCubit>().onCountrySelected(selected);
                              }
                            },
                      child: IgnorePointer(
                        child: CommonTextField(
                          controller: _countryController,
                          readOnly: true,
                          hintText: state.isLoadingCountries
                              ? localizations.loadingCountries
                              : localizations.registerCountryHint,
                          suffixIcon: state.isLoadingCountries
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              : SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // State Picker
              InputFieldDecoration(
                labelText: localizations.registerStateHint,
                isRequired: true,
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.states != current.states ||
                      previous.selectedState != current.selectedState ||
                      previous.isLoadingStates != current.isLoadingStates ||
                      previous.selectedCountry != current.selectedCountry,
                  builder: (context, state) {
                    final isCountrySelected = state.selectedCountry != null;
                    String hintText;
                    if (!isCountrySelected) {
                      hintText = localizations.selectCountryFirst;
                    } else if (state.isLoadingStates) {
                      hintText = localizations.loadingStates;
                    } else {
                      hintText = localizations.registerStateHint;
                    }

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (!isCountrySelected) {
                          showGeneralMessage(context: context, content: localizations.pleaseSelectCountryFirst);
                          return;
                        }
                        if (state.isLoadingStates) return;

                        final selected = await LocationPickerBottomSheet.show<LocationState>(
                          context: context,
                          title: localizations.registerStateHint,
                          searchHint: localizations.searchState,
                          items: state.states,
                          itemLabel: (s) => s.name,
                          itemId: (s) => s.id,
                          selectedId: state.selectedState?.id,
                        );
                        if (selected != null && context.mounted) {
                          context.read<RegisterCubit>().onStateSelected(selected);
                        }
                      },
                      child: IgnorePointer(
                        child: CommonTextField(
                          controller: _stateController,
                          readOnly: true,
                          hintText: hintText,
                          suffixIcon: state.isLoadingStates
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              : SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // City Picker
              InputFieldDecoration(
                labelText: localizations.registerCityHint,
                isRequired: true,
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.cities != current.cities ||
                      previous.selectedCity != current.selectedCity ||
                      previous.isLoadingCities != current.isLoadingCities ||
                      previous.selectedState != current.selectedState,
                  builder: (context, state) {
                    final isStateSelected = state.selectedState != null;
                    String hintText;
                    if (!isStateSelected) {
                      hintText = localizations.selectStateFirst;
                    } else if (state.isLoadingCities) {
                      hintText = localizations.loadingCities;
                    } else if (state.cities.isEmpty) {
                      hintText = localizations.noCitiesAvailable;
                    } else {
                      hintText = localizations.registerCityHint;
                    }

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (!isStateSelected) {
                          showGeneralMessage(context: context, content: localizations.pleaseSelectStateFirst);
                          return;
                        }
                        if (state.isLoadingCities) return;
                        if (state.cities.isEmpty) {
                          showGeneralMessage(context: context, content: localizations.noCitiesAvailable);
                          return;
                        }

                        final selected = await LocationPickerBottomSheet.show<LocationCity>(
                          context: context,
                          title: localizations.registerCityHint,
                          searchHint: localizations.searchCity,
                          items: state.cities,
                          itemLabel: (c) => c.name,
                          itemId: (c) => c.id,
                          selectedId: state.selectedCity?.id,
                        );
                        if (selected != null && context.mounted) {
                          context.read<RegisterCubit>().onCitySelected(selected);
                        }
                      },
                      child: IgnorePointer(
                        child: CommonTextField(
                          controller: _cityController,
                          readOnly: true,
                          hintText: hintText,
                          suffixIcon: state.isLoadingCities
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              : SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Address Field
              InputFieldDecoration(
                labelText: localizations.registerAddressHint,
                child: BlocSelector<RegisterCubit, RegisterState, AddressInput>(
                  selector: (state) => state.addressInput,
                  builder: (context, addressInput) {
                    return CommonTextField(
                      controller: _addressController,
                      hintText: localizations.registerAddressPlaceholder,
                      errorText: addressInput.displayError?.getErrorMessage(context),
                      onChanged: (value) => context.read<RegisterCubit>().onAddressChanged(value),
                    );
                  },
                ),
              ),

              // Pincode Field
              InputFieldDecoration(
                labelText: localizations.registerPincodeHint,
                child: BlocSelector<RegisterCubit, RegisterState, PincodeInput>(
                  selector: (state) => state.pincodeInput,
                  builder: (context, pincodeInput) {
                    return CommonTextField(
                      controller: _pincodeController,
                      keyboardType: TextInputType.number,
                      hintText: localizations.registerPincodePlaceholder,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      errorText: pincodeInput.displayError?.getErrorMessage(context),
                      onChanged: (value) => context.read<RegisterCubit>().onPincodeChanged(value),
                    );
                  },
                ),
              ),

              // Email Address
              InputFieldDecoration(
                labelText: localizations.registerEmailHint,
                child: BlocSelector<RegisterCubit, RegisterState, EmailAddressInput>(
                  selector: (state) => state.emailInput,
                  builder: (context, emailInput) {
                    return CommonTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: localizations.registerEmailHint,
                      errorText: emailInput.displayError?.getErrorMessage(context),
                      onChanged: (value) => context.read<RegisterCubit>().onEmailChanged(value),
                      prefixIcon: SvgImageFromAsset.square(
                        SvgIcons.icnEmail,
                        size: 22,
                        color: context.colorScheme.onSurface,
                      ),
                    );
                  },
                ),
              ),

              // Mobile Number
              InputFieldDecoration(
                labelText: localizations.registerMobileHint,
                child: BlocSelector<RegisterCubit, RegisterState, EmailMobileInput>(
                  selector: (state) => state.mobileInput,
                  builder: (context, mobileInput) {
                    return MobileNumberField(
                      controller: _mobileNumberController,
                      hintText: localizations.registerMobileHint,
                      keyboardType: TextInputType.phone,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      isMobileField: true,
                      onChanged: (value) {
                        context.read<RegisterCubit>().onMobileChanged(
                          value,
                          _mobileNumberController.country.phoneDetail,
                        );
                      },
                      errorText: mobileInput.displayError?.getErrorMessage(context),
                      isoCode: _mobileNumberController.country.isoCode,
                    );
                  },
                ),
              ),

              // Password
              InputFieldDecoration(
                labelText: localizations.registerPasswordHint,
                child: BlocSelector<RegisterCubit, RegisterState, PasswordInput>(
                  selector: (state) => state.passwordInput,
                  builder: (context, passwordInput) {
                    return PasswordTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => context.read<RegisterCubit>().onPasswordChanged(value),
                      onFieldSubmitted: (value) => _confirmPasswordFocusNode.requestFocus(),
                      hintText: localizations.registerPasswordHint,
                      errorText: passwordInput.displayError?.getErrorMessage(context),
                      isDisplayPrefix: true,
                    );
                  },
                ),
              ),

              // Confirm Password
              InputFieldDecoration(
                labelText: localizations.registerConfirmPasswordHint,
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.confirmPasswordInput != current.confirmPasswordInput ||
                      previous.passwordInput != current.passwordInput,
                  builder: (context, state) {
                    final confirmPasswordInput = state.confirmPasswordInput;
                    return PasswordTextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => context.read<RegisterCubit>().onConfirmPasswordChanged(value),
                      onFieldSubmitted: (value) => _confirmPasswordFocusNode.unfocus(),
                      hintText: localizations.registerConfirmPasswordHint,
                      errorText:
                          confirmPasswordInput.displayError?.getErrorMessage(context) ??
                          (confirmPasswordInput.isPure
                              ? null
                              : confirmPasswordInput.compare(state.passwordInput.value)?.getErrorMessage(context)),
                      isDisplayPrefix: true,
                    );
                  },
                ),
              ),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: context.select((RegisterCubit cubit) => cubit.state.agreedToTerms),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (value) => context.read<RegisterCubit>().onTermsAgreed(value ?? false),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: localizations.agreeTermsPrefix,
                        children: [
                          TextSpan(
                            text: localizations.termsOfService,
                            style: TextStyle(fontWeight: FontWeight.bold, color: context.colorScheme.primary),
                          ),
                          TextSpan(text: localizations.andLabel),
                          TextSpan(
                            text: localizations.privacyPolicy,
                            style: TextStyle(fontWeight: FontWeight.bold, color: context.colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
