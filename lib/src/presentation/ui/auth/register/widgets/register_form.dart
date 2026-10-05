import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
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
  late final TextEditingController _emailController;
  late final MobileNumberController _mobileNumberController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    final state = context.read<RegisterCubit>().state;
    _nameController = TextEditingController(text: state.nameInput.value);
    _surnameController = TextEditingController(text: state.surnameInput.value);
    _emailController = TextEditingController(text: state.emailInput.value);
    _mobileNumberController = MobileNumberController(text: state.mobileInput.value);
    _passwordController = TextEditingController(text: state.passwordInput.value);
    _confirmPasswordController = TextEditingController(text: state.confirmPasswordInput.value);
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.xLarge,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          spacing: Spacing.normal,
          children: [
            InputFieldDecoration(
              labelText: "Your Name",
              child: BlocSelector<RegisterCubit, RegisterState, UserFullNameInput>(
                selector: (state) => state.nameInput,
                builder: (context, nameInput) {
                  return CommonTextField(
                    controller: _nameController,
                    hintText: "Your Name",
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
            InputFieldDecoration(
              labelText: "Your Surname",
              child: BlocSelector<RegisterCubit, RegisterState, UserFullNameInput>(
                selector: (state) => state.surnameInput,
                builder: (context, surnameInput) {
                  return CommonTextField(
                    controller: _surnameController,
                    hintText: "Your Surname",
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
            InputFieldDecoration(
              labelText: "Country",
              child: DropdownButtonFormField<String>(
                icon: SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                decoration: const InputDecoration(hintText: "Select"),
                items: ['United States', 'India', 'United Kingdom'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => context.read<RegisterCubit>().onCountryChanged(value ?? ''),
              ),
            ),
            InputFieldDecoration(
              labelText: "State",
              child: DropdownButtonFormField<String>(
                icon: SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                decoration: const InputDecoration(hintText: "Select"),
                items: ['State 1', 'State 2', 'State 3'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => context.read<RegisterCubit>().onStateChanged(value ?? ''),
              ),
            ),
            InputFieldDecoration(
              labelText: "City",
              child: DropdownButtonFormField<String>(
                icon: SvgImageFromAsset.square(SvgIcons.arrowDown, size: 20),
                decoration: const InputDecoration(hintText: "Select"),
                items: ['City 1', 'City 2', 'City 3'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => context.read<RegisterCubit>().onCityChanged(value ?? ''),
              ),
            ),
            InputFieldDecoration(
              labelText: "Your Email Address (Optional)",
              child: BlocSelector<RegisterCubit, RegisterState, EmailAddressInput>(
                selector: (state) => state.emailInput,
                builder: (context, emailInput) {
                  return CommonTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Your Email Address (Optional)",
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
            InputFieldDecoration(
              labelText: "Your mobile number",
              child: BlocSelector<RegisterCubit, RegisterState, EmailMobileInput>(
                selector: (state) => state.mobileInput,
                builder: (context, mobileInput) {
                  return MobileNumberField(
                    controller: _mobileNumberController,
                    hintText: "Your mobile number",
                    keyboardType: TextInputType.phone,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    isMobileField: true,
                    onChanged: (value) {
                      context.read<RegisterCubit>().onMobileChanged(value, _mobileNumberController.country.phoneDetail);
                    },
                    errorText: mobileInput.displayError?.getErrorMessage(context),
                    isoCode: _mobileNumberController.country.isoCode,
                  );
                },
              ),
            ),
            InputFieldDecoration(
              labelText: "Enter Password",
              child: BlocSelector<RegisterCubit, RegisterState, PasswordInput>(
                selector: (state) => state.passwordInput,
                builder: (context, passwordInput) {
                  return PasswordTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => context.read<RegisterCubit>().onPasswordChanged(value),
                    onFieldSubmitted: (value) => _confirmPasswordFocusNode.requestFocus(),
                    hintText: "Enter Password",
                    errorText: passwordInput.displayError?.getErrorMessage(context),
                    isDisplayPrefix: true,
                  );
                },
              ),
            ),
            InputFieldDecoration(
              labelText: "Confirm Password",
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
                    hintText: "Confirm Password",
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
                      text: "By creating an account, you agree to our ",
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(fontWeight: FontWeight.bold, color: context.colorScheme.primary),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
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
    );
  }
}
