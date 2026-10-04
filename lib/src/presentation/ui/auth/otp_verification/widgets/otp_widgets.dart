import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:pinput/pinput.dart';

class OtpInputField extends StatelessWidget {
  const OtpInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.autofocus = false,
    this.inputAction,
    this.onChanged,
    this.onCompleted,
    this.errorText,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction? inputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final decoration = PinTheme(
      textStyle: TextStyle(fontSize: 20, color: colorScheme.onSurface, fontWeight: FontWeight.w600, height: 1.5),
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, borderRadius: ShapeBorderRadius.small),
    );

    return Pinput(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      mainAxisAlignment: MainAxisAlignment.center,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: inputAction,
      length: 4,
      autofillHints: const {AutofillHints.oneTimeCode},
      separatorBuilder: (index) => const Gap(Spacing.normal),
      defaultPinTheme: decoration.copyBorderWith(border: Border.all(color: colorScheme.primary, width: 2)),
      errorPinTheme: decoration.copyBorderWith(border: Border.all(color: colorScheme.error, width: 2)),
      disabledPinTheme: decoration.copyBorderWith(border: Border.all(color: colorScheme.primary, width: 2)),
      focusedPinTheme: decoration.copyBorderWith(border: Border.all(color: colorScheme.primary, width: 2)),
      submittedPinTheme: decoration.copyBorderWith(border: Border.all(color: colorScheme.primary, width: 2)),
      closeKeyboardWhenCompleted: true,
      pinAnimationType: PinAnimationType.scale,
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}

Future<void> onOtpVerified(BuildContext context, {required VoidCallback onTap}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return CustomAlertDialog(
        icon: LottieBuilder.asset(LottieFiles.success, fit: BoxFit.cover),
        title: context.localizations.success,
        description: context.localizations.otpVerifiedSuccessfully,
        action: ElevatedButton(
          onPressed: () {
            context.navigator.pop();
            onTap.call();
          },
          style: ElevatedButtonPrimaryStyle(context),
          child: Text(context.localizations.continueButtonLabel),
        ),
      );
    },
  );
}
