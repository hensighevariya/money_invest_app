import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

import '../../widgets/auth_title.dart';
import '../logic/reset_password_cubit.dart';
import '../logic/reset_password_state.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();

    final state = context.read<ResetPasswordCubit>().state;
    _passwordController = TextEditingController(text: state.passwordInput.value);
    _confirmPasswordController = TextEditingController(text: state.confirmPasswordInput.value);
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onContinue() {
    FocusScope.of(context).unfocus();
    context.read<ResetPasswordCubit>().onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return AutofillGroup(
      child: Column(
        spacing: Spacing.xLarge,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset(
              AppImages.appLargeLogo,
              width: MediaQuery.sizeOf(context).width * 0.8,
              fit: BoxFit.contain,
            ),
          ),
          const Gap(Spacing.xxxLarge),
          AuthTitle(
            title: localizations.resetPasswordTitle,
            description: TextSpan(text: localizations.resetPasswordDesc),
          ),
          Column(
            spacing: Spacing.normal,
            children: [
              InputFieldDecoration(
                labelText: localizations.loginPasswordHint,
                child: BlocSelector<ResetPasswordCubit, ResetPasswordState, PasswordInput>(
                  selector: (state) => state.passwordInput,
                  builder: (context, passwordInput) {
                    return PasswordTextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.next,
                      autofillHints: {AutofillHints.newPassword},
                      onChanged: (value) => context.read<ResetPasswordCubit>().onPasswordChanged(value),
                      onEditingComplete: () => _confirmPasswordFocusNode.requestFocus(),
                      onFieldSubmitted: (value) => _confirmPasswordFocusNode.requestFocus(),
                      hintText: localizations.loginPasswordHint,
                      maxLength: 20,
                      errorText: passwordInput.displayError?.getErrorMessage(context),
                    );
                  },
                ),
              ),
              InputFieldDecoration(
                labelText: localizations.confirmPasswordHint,
                child: BlocSelector<ResetPasswordCubit, ResetPasswordState, ConfirmPasswordInput>(
                  selector: (state) => state.confirmPasswordInput,
                  builder: (context, confirmPasswordInput) {
                    final passwordValue = context.select<ResetPasswordCubit, String>(
                      (value) => value.state.passwordInput.value,
                    );

                    return PasswordTextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      autofillHints: {AutofillHints.newPassword},
                      onChanged: (value) => context.read<ResetPasswordCubit>().onConfirmPasswordChanged(value),
                      onFieldSubmitted: (value) => _confirmPasswordFocusNode.unfocus(),
                      hintText: localizations.confirmPasswordHint,
                      maxLength: 20,
                      errorText:
                          confirmPasswordInput.displayError?.getErrorMessage(context) ??
                          (!confirmPasswordInput.isPure
                              ? confirmPasswordInput.compare(passwordValue)?.getErrorMessage(context)
                              : null),
                    );
                  },
                ),
              ),
            ],
          ),
          BlocSelector<ResetPasswordCubit, ResetPasswordState, bool>(
            selector: (state) => state.isValid && (state.confirmPasswordInput.value == state.passwordInput.value),
            builder: (context, isValid) {
              return ElevatedButton(
                style: ElevatedButtonPrimaryStyle(context),
                onPressed: !isValid ? null : _onContinue,
                child: Text(localizations.continueButtonLabel),
              );
            },
          ),
        ],
      ),
    );
  }
}
