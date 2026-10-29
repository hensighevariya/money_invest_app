import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

import '../logic/change_password_cubit.dart';
import '../logic/change_password_state.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _currentPasswordFocusNode;
  late final FocusNode _newPasswordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();

    final state = context.read<ChangePasswordCubit>().state;
    _currentPasswordController =
        TextEditingController(text: state.currentPasswordInput.value);
    _newPasswordController =
        TextEditingController(text: state.newPasswordInput.value);
    _confirmPasswordController =
        TextEditingController(text: state.confirmPasswordInput.value);
    _currentPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    context.read<ChangePasswordCubit>().onSubmit();
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
            spacing: Spacing.normal,
            children: [
              InputFieldDecoration(
                labelText: localizations.currentPasswordFieldLabel,
                child: BlocSelector<
                  ChangePasswordCubit,
                  ChangePasswordState,
                  UserPasswordInput
                >(
                  selector: (state) => state.currentPasswordInput,
                  builder: (context, currentPasswordInput) {
                    return PasswordTextField(
                      controller: _currentPasswordController,
                      focusNode: _currentPasswordFocusNode,
                      textInputAction: TextInputAction.next,
                      autofillHints: const {AutofillHints.password},
                      onChanged: (value) => context
                          .read<ChangePasswordCubit>()
                          .onCurrentPasswordChanged(value),
                      onEditingComplete: () =>
                          _newPasswordFocusNode.requestFocus(),
                      onFieldSubmitted: (value) =>
                          _newPasswordFocusNode.requestFocus(),
                      hintText: localizations.currentPasswordFieldHint,
                      maxLength: 20,
                      errorText: currentPasswordInput.displayError
                          ?.getErrorMessage(context),
                    );
                  },
                ),
              ),
              InputFieldDecoration(
                labelText: localizations.newPasswordFieldLabel,
                child: BlocSelector<
                  ChangePasswordCubit,
                  ChangePasswordState,
                  PasswordInput
                >(
                  selector: (state) => state.newPasswordInput,
                  builder: (context, newPasswordInput) {
                    final currentPasswordValue = context
                        .select<ChangePasswordCubit, String>(
                          (value) => value.state.currentPasswordInput.value,
                        );
                    final localErrorText =
                        newPasswordInput.displayError?.getErrorMessage(context);
                    final sameAsCurrent =
                        !newPasswordInput.isPure &&
                        newPasswordInput.value.isNotEmpty &&
                        currentPasswordValue.isNotEmpty &&
                        newPasswordInput.value == currentPasswordValue;

                    return PasswordTextField(
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocusNode,
                      textInputAction: TextInputAction.next,
                      autofillHints: const {AutofillHints.newPassword},
                      onChanged: (value) => context
                          .read<ChangePasswordCubit>()
                          .onNewPasswordChanged(value),
                      onEditingComplete: () =>
                          _confirmPasswordFocusNode.requestFocus(),
                      onFieldSubmitted: (value) =>
                          _confirmPasswordFocusNode.requestFocus(),
                      hintText: localizations.newPasswordFieldHint,
                      maxLength: 20,
                      errorText: localErrorText ??
                          (sameAsCurrent
                              ? localizations.errorNewPasswordSameAsCurrent
                              : null),
                    );
                  },
                ),
              ),
              InputFieldDecoration(
                labelText: localizations.confirmPasswordFieldLabel,
                child: BlocSelector<
                  ChangePasswordCubit,
                  ChangePasswordState,
                  ConfirmPasswordInput
                >(
                  selector: (state) => state.confirmPasswordInput,
                  builder: (context, confirmPasswordInput) {
                    final newPasswordValue = context
                        .select<ChangePasswordCubit, String>(
                          (value) => value.state.newPasswordInput.value,
                        );

                    return PasswordTextField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      autofillHints: const {AutofillHints.newPassword},
                      onChanged: (value) => context
                          .read<ChangePasswordCubit>()
                          .onConfirmPasswordChanged(value),
                      hintText: localizations.confirmPasswordFieldHint,
                      maxLength: 20,
                      errorText:
                          confirmPasswordInput.displayError
                              ?.getErrorMessage(context) ??
                          (!confirmPasswordInput.isPure
                              ? confirmPasswordInput
                                    .compare(newPasswordValue)
                                    ?.getErrorMessage(context)
                              : null),
                    );
                  },
                ),
              ),
            ],
          ),
          BlocSelector<ChangePasswordCubit, ChangePasswordState, bool>(
            selector: (state) => state.canSubmit,
            builder: (context, canSubmit) {
              return ElevatedButton(
                style: ElevatedButtonPrimaryStyle(context),
                onPressed: !canSubmit ? null : _onSubmit,
                child: Text(
                  localizations.continueButtonLabel,
                  style: TextStyle(color: context.colorScheme.onPrimary),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

