import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/components/mobile_number_field.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';
import '../logic/login_cubit.dart';
import '../logic/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final MobileNumberController _mobileNumberController;
  late final TextEditingController _passwordController;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    final state = context.read<LoginCubit>().state;
    _mobileNumberController = MobileNumberController(text: state.emailMobileInput.value);
    _passwordController = TextEditingController(text: state.passwordInput.value);
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    FocusScope.of(context).unfocus();
    context.go('/home');

    // await context.read<LoginCubit>().onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return AutofillGroup(
      child: Column(
        spacing: Spacing.xLarge,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Column(
                spacing: Spacing.normal,
                children: [
                  InputFieldDecoration(
                    labelText: localizations.loginEmailHint,
                    child: BlocSelector<LoginCubit, LoginState, EmailMobileInput>(
                      selector: (state) => state.emailMobileInput,
                      builder: (context, emailAddressInput) {
                        return MobileNumberField(
                          controller: _mobileNumberController,
                          hintText: localizations.loginEmailHint,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: () => _passwordFocusNode.requestFocus(),
                          onFieldSubmitted: (value) => _passwordFocusNode.requestFocus(),
                          onChanged: (value) {
                            context.read<LoginCubit>().onEmailAddressChanged(
                              value,
                              _mobileNumberController.country.phoneDetail,
                            );
                          },
                          errorText: emailAddressInput.displayError?.getErrorMessage(context),
                          isoCode: _mobileNumberController.country.isoCode,
                        );
                      },
                    ),
                  ),
                  InputFieldDecoration(
                    labelText: localizations.loginPasswordHint,
                    child: BlocSelector<LoginCubit, LoginState, UserPasswordInput>(
                      selector: (state) => state.passwordInput,
                      builder: (context, passwordInput) {
                        return PasswordTextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          autofillHints: {AutofillHints.password},
                          onChanged: (value) => context.read<LoginCubit>().onPasswordChanged(value),
                          onFieldSubmitted: (value) => _passwordFocusNode.unfocus(),
                          hintText: localizations.loginPasswordHint,
                          errorText: passwordInput.displayError?.getErrorMessage(context),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: PaddingValue.small, visualDensity: VisualDensity.compact),
                      onPressed: () => context.go('${context.currentPath}/forgot-password'),
                      child: Text(
                        localizations.loginForgotPassword,
                        style: TextStyle(
                          color: context.colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          BlocSelector<LoginCubit, LoginState, bool>(
            selector: (state) => state.isValid,
            builder: (context, isValid) {
              return ElevatedButton(
                style: ElevatedButtonPrimaryStyle(context, buttonColor: context.colorScheme.primary),
                onPressed: /*!isValid ? null :*/ _onContinue,
                child: Text(localizations.continueButtonLabel),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizations.dontHaveAccount,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.go('${context.currentPath}/register');
                },
                child: Text(
                  localizations.signUp,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
