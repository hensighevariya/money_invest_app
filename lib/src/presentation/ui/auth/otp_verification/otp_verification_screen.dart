import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:money_invest_app/src/app/routes/routes.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/model/auth_navigation_data_model.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/ui/auth/otp_verification/logic/otp_verification_cubit.dart';
import 'package:money_invest_app/src/presentation/ui/auth/otp_verification/logic/otp_verification_state.dart';
import 'package:money_invest_app/src/presentation/ui/auth/otp_verification/widgets/otp_widgets.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';
import 'package:money_invest_app/src/utils/loading_dialog_handler.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key, this.data});

  final AuthNavigationDataModel? data;

  void _onStatusChanged(BuildContext context, OtpVerificationState state) {
    if (state.status case ProgressStatusSuccess<OtpVerificationStatusData>(
      result: OtpVerificationStatusData? statusData,
    )) {
      onOtpVerified(
        context,
        onTap: () => (data?.isFromEditProfile ?? false)
            ? context.go('${context.currentPath}/edit-profile')
            : context.go(
                '${context.currentPath}/reset-password',
                extra: AuthNavigationDataModel(type: statusData.type, token: statusData.token),
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OtpVerificationCubit(
          verificationToken: data?.token ?? '',
          resetByMobile: data?.resetByMobile ?? false,
          emailAddressORMobile: data?.emailMobileInput ?? '',
          authRepository: RepositoryProvider.of(context),
          loadingHandler: LoadingDialogHandler(context: context),
          type: data?.type ?? 0,
          verifyType: data?.verifyType ?? 0,
        );
      },
      child: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _onStatusChanged,
        child: const _OtpVerificationView(),
      ),
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  const _OtpVerificationView();

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  late final TextEditingController _codeController;
  late final FocusNode _codeFocusNode;

  @override
  void initState() {
    super.initState();
    final state = context.read<OtpVerificationCubit>().state;
    _codeController = TextEditingController(text: state.otpCodeInput.value);
    _codeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  void _onContinue() {
    FocusScope.of(context).unfocus();
    context.read<OtpVerificationCubit>().onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Scaffold(
      appBar: CustomAppBar(color: context.colorScheme.surface),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.all(Spacing.large),
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: Spacing.normal,
                  children: [
                    SizedBox.square(
                      dimension: context.height < 650 ? 220 : 300,
                      child: Center(child: LottieBuilder.asset(LottieFiles.otpVerification, width: 300)),
                    ),
                    Column(
                      spacing: Spacing.xxxLarge,
                      children: [
                        Builder(
                          builder: (context) {
                            final emailAddress = context.select<OtpVerificationCubit, String>(
                              (value) => value.state.emailAddressORMobile,
                            );
                            return AuthTitle(
                              title: localizations.otpVerificationTitle,
                              description: TextSpan(
                                text: context.read<OtpVerificationCubit>().state.resetByMobile
                                    ? localizations.otpVerificationScreenDescriptionMobile
                                    : localizations.otpVerificationScreenDescriptionEmail,
                                children: [
                                  const TextSpan(text: ' '),
                                  TextSpan(
                                    text: emailAddress,
                                    style: TextStyle(fontWeight: FontWeight.w600, color: context.colorScheme.primary),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        BlocSelector<OtpVerificationCubit, OtpVerificationState, OtpCodeInput>(
                          selector: (state) => state.otpCodeInput,
                          builder: (context, otpCodeInput) {
                            return OtpInputField(
                              controller: _codeController,
                              focusNode: _codeFocusNode,
                              inputAction: TextInputAction.done,
                              onChanged: (value) => context.read<OtpVerificationCubit>().onOtpCodeChanged(value),
                            );
                          },
                        ),
                        BlocSelector<OtpVerificationCubit, OtpVerificationState, bool>(
                          selector: (state) => state.isValid,
                          builder: (context, isValid) {
                            return ElevatedButton(
                              style: ElevatedButtonPrimaryStyle(context),
                              onPressed: /*!isValid ? null :*/ _onContinue,
                              child: Text(localizations.continueButtonLabel),
                            );
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: BlocSelector<OtpVerificationCubit, OtpVerificationState, Duration>(
                        selector: (state) => state.remainingDuration,
                        builder: (context, remainingDuration) {
                          return LinkText(
                            textAlign: TextAlign.center,
                            spans: [
                              TextSpan(
                                text: localizations.didntReceivedCode,
                                style: TextStyle(color: context.colorScheme.onSurface),
                              ),
                              if (remainingDuration > Duration.zero) ...[
                                const TextSpan(text: ' '),
                                TextSpan(
                                  text: localizations.resendIn,
                                  style: TextStyle(color: context.colorScheme.onSurface),
                                ),
                                TextSpan(
                                  text: localizations.resendTimer(
                                    remainingDuration.inSeconds.toString().padLeft(2, '0'),
                                  ),
                                  style: TextStyle(fontWeight: FontWeight.w600, color: context.colorScheme.primary),
                                ),
                              ] else ...[
                                LinkTextSpan(
                                  text: localizations.resendCodeLink,
                                  onPressed: () {
                                    context.read<OtpVerificationCubit>().resendOtpCode();
                                    showSuccessMessage(context: context, content: localizations.successfullyResentCode);
                                  },
                                  style: TextStyle(color: context.colorScheme.onSurface),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
