import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:money_invest_app/src/localization/localization.dart';
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

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

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

  Widget _buildPasswordField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required ValueChanged<String> onChanged,
    String? errorText,
    TextInputAction textInputAction = TextInputAction.next,
    VoidCallback? onEditingComplete,
    VoidCallback? onFieldSubmitted,
    Iterable<String>? autofillHints,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[A-Za-z0-9!@#$%^&*_,.?’:;"]'),
            ),
            LengthLimitingTextInputFormatter(20),
          ],
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onFieldSubmitted != null ? (_) => onFieldSubmitted() : null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF8E95A5), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFF1C202C),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2E3548)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF547AFF)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFFF5252)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFFF5252)),
            ),
            errorText: errorText,
            errorStyle: const TextStyle(color: Color(0xFFFF5252), fontSize: 12),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: const Color(0xFF8E95A5),
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Current Password Field
          BlocSelector<ChangePasswordCubit, ChangePasswordState, UserPasswordInput>(
            selector: (state) => state.currentPasswordInput,
            builder: (context, currentPasswordInput) {
              return _buildPasswordField(
                label: localizations.currentPasswordFieldLabel,
                hintText: localizations.currentPasswordFieldHint,
                controller: _currentPasswordController,
                focusNode: _currentPasswordFocusNode,
                obscureText: _obscureCurrentPassword,
                onToggleVisibility: () {
                  setState(() => _obscureCurrentPassword = !_obscureCurrentPassword);
                },
                textInputAction: TextInputAction.next,
                autofillHints: const {AutofillHints.password},
                onChanged: (value) =>
                    context.read<ChangePasswordCubit>().onCurrentPasswordChanged(value),
                onEditingComplete: () => _newPasswordFocusNode.requestFocus(),
                onFieldSubmitted: () => _newPasswordFocusNode.requestFocus(),
                errorText: currentPasswordInput.displayError?.getErrorMessage(context),
              );
            },
          ),
          const Gap(20),

          // New Password Field
          BlocSelector<ChangePasswordCubit, ChangePasswordState, PasswordInput>(
            selector: (state) => state.newPasswordInput,
            builder: (context, newPasswordInput) {
              final currentPasswordValue = context.select<ChangePasswordCubit, String>(
                (value) => value.state.currentPasswordInput.value,
              );
              final localErrorText = newPasswordInput.displayError?.getErrorMessage(context);
              final sameAsCurrent = !newPasswordInput.isPure &&
                  newPasswordInput.value.isNotEmpty &&
                  currentPasswordValue.isNotEmpty &&
                  newPasswordInput.value == currentPasswordValue;

              return _buildPasswordField(
                label: localizations.newPasswordFieldLabel,
                hintText: localizations.newPasswordFieldHint,
                controller: _newPasswordController,
                focusNode: _newPasswordFocusNode,
                obscureText: _obscureNewPassword,
                onToggleVisibility: () {
                  setState(() => _obscureNewPassword = !_obscureNewPassword);
                },
                textInputAction: TextInputAction.next,
                autofillHints: const {AutofillHints.newPassword},
                onChanged: (value) =>
                    context.read<ChangePasswordCubit>().onNewPasswordChanged(value),
                onEditingComplete: () => _confirmPasswordFocusNode.requestFocus(),
                onFieldSubmitted: () => _confirmPasswordFocusNode.requestFocus(),
                errorText: localErrorText ??
                    (sameAsCurrent ? localizations.errorNewPasswordSameAsCurrent : null),
              );
            },
          ),
          const Gap(20),

          // Confirm Password Field
          BlocSelector<ChangePasswordCubit, ChangePasswordState, ConfirmPasswordInput>(
            selector: (state) => state.confirmPasswordInput,
            builder: (context, confirmPasswordInput) {
              final newPasswordValue = context.select<ChangePasswordCubit, String>(
                (value) => value.state.newPasswordInput.value,
              );

              return _buildPasswordField(
                label: localizations.confirmPasswordFieldLabel,
                hintText: localizations.confirmPasswordFieldHint,
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                obscureText: _obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                },
                textInputAction: TextInputAction.done,
                autofillHints: const {AutofillHints.newPassword},
                onChanged: (value) =>
                    context.read<ChangePasswordCubit>().onConfirmPasswordChanged(value),
                onEditingComplete: _onSubmit,
                onFieldSubmitted: _onSubmit,
                errorText: confirmPasswordInput.displayError?.getErrorMessage(context) ??
                    (!confirmPasswordInput.isPure
                        ? confirmPasswordInput
                            .compare(newPasswordValue)
                            ?.getErrorMessage(context)
                        : null),
              );
            },
          ),
          const Gap(32),

          // Submit Button
          BlocSelector<ChangePasswordCubit, ChangePasswordState, bool>(
            selector: (state) => state.canSubmit,
            builder: (context, canSubmit) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E73F8),
                  disabledBackgroundColor: const Color(0xFF4E73F8).withValues(alpha: 0.35),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: !canSubmit ? null : _onSubmit,
                child: Text(
                  localizations.continueButtonLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

