import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/components/mobile_number_field.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/ui/auth/forgot_password/logic/forgot_password_cubit.dart';
import 'package:money_invest_app/src/presentation/ui/auth/forgot_password/logic/forgot_password_state.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';
import 'package:money_invest_app/src/utils/form_inputs/email_mobile.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  late final MobileNumberController _mobileNumberController;
  late final FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    final state = context.read<ForgotPasswordCubit>().state;
    _mobileNumberController = MobileNumberController(text: state.emailMobileInput.value);
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _onContinue() {
    FocusScope.of(context).unfocus();
    context.read<ForgotPasswordCubit>().onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return AutofillGroup(
      child: Column(
        spacing: Spacing.xLarge,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.xLarge),
            child: SizedBox.square(
              dimension: context.height < 650 ? 220 : 300,
              child: Center(child: LottieBuilder.asset(LottieFiles.forgotPassword, width: 300)),
            ),
          ),
          AuthTitle(
            title: localizations.forgotPasswordTitle,
            description: TextSpan(text: localizations.forgotPasswordSubtitle),
          ),
          InputFieldDecoration(
            labelText: localizations.loginEmailHint,
            child: BlocSelector<ForgotPasswordCubit, ForgotPasswordState, EmailMobileInput>(
              selector: (state) => state.emailMobileInput,
              builder: (context, emailAddressInput) {
                return MobileNumberField(
                  controller: _mobileNumberController,
                  hintText: localizations.loginEmailHint,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<ForgotPasswordCubit>().onEmailAddressChanged(
                    value,
                    _mobileNumberController.country.phoneDetail,
                  ),
                  errorText: emailAddressInput.displayError?.getErrorMessage(context),
                  isoCode: _mobileNumberController.country.isoCode,
                );
              },
            ),
          ),
          BlocSelector<ForgotPasswordCubit, ForgotPasswordState, bool>(
            selector: (state) => state.isValid,
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
