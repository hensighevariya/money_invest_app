import 'dart:async';
import 'package:common_extensions/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/presentation.dart';
import 'package:money_invest_app/src/presentation/components/alert_message.dart';
import 'package:money_invest_app/src/utils/helper_functions.dart';
import 'package:money_invest_app/src/presentation/components/appbar.dart';
import 'package:money_invest_app/src/presentation/components/common_input_field.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';
import 'package:money_invest_app/src/presentation/resources/size.dart';
import 'package:money_invest_app/src/presentation/ui/auth/widgets/auth_title.dart';

class RegisterOtpScreen extends StatefulWidget {
  const RegisterOtpScreen({
    super.key,
    required this.mobile,
    required this.email,
    required this.emailToken,
    required this.mobileToken,
  });

  final String mobile;
  final String email;
  final String emailToken;
  final String mobileToken;

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  late final TextEditingController _mobileOtpController;
  late final TextEditingController _emailOtpController;

  Timer? _mobileTimer;
  Timer? _emailTimer;
  int _mobileRemainingSeconds = 60;
  int _emailRemainingSeconds = 60;

  bool _isVerifying = false;
  bool _isResendingMobile = false;
  bool _isResendingEmail = false;

  bool _isMobileVerified = false;
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    _mobileOtpController = TextEditingController();
    _emailOtpController = TextEditingController();

    _mobileOtpController.addListener(_onMobileOtpChanged);
    _emailOtpController.addListener(_onEmailOtpChanged);

    _startTimer(isMobile: true);
    _startTimer(isMobile: false);
  }

  @override
  void dispose() {
    _mobileTimer?.cancel();
    _emailTimer?.cancel();
    _mobileOtpController.dispose();
    _emailOtpController.dispose();
    super.dispose();
  }

  void _onMobileOtpChanged() {
    final otp = _mobileOtpController.text.trim();
    if (otp.length == 6 && !_isVerifying && !_isMobileVerified) {
      _verifyOtp(type: 'mobile', otp: otp);
    }
  }

  void _onEmailOtpChanged() {
    final otp = _emailOtpController.text.trim();
    if (otp.length == 6 && !_isVerifying && !_isEmailVerified) {
      _verifyOtp(type: 'email', otp: otp);
    }
  }

  Future<void> _verifyOtp({required String type, required String otp}) async {
    if (_isVerifying) return;
    final isMobile = type == 'mobile';
    final token = isMobile ? widget.mobileToken : widget.emailToken;

    if (token.isEmpty) {
      showErrorMessage(
        context: context,
        content: "Session token is missing. Please register again.",
      );
      return;
    }

    setState(() => _isVerifying = true);
    FocusScope.of(context).unfocus();

    try {
      final authRepo = RepositoryProvider.of<AuthRepository>(context);
      final responseData = await authRepo.verifyRegistrationOtp(
        token: token,
        otp: otp,
        type: type,
      );

      if (!mounted) return;

      setState(() {
        if (isMobile) {
          _isMobileVerified = true;
        } else {
          _isEmailVerified = true;
        }
      });

      final isCompleted = responseData.isCompleted == true;
      final serverMsg = responseData.message;

      if (isCompleted) {
        final user = responseData.user ?? const UserData(id: '');
        context.read<UserProfileBloc>().add(UserLoggedIn(user));
        context.read<UserProfileBloc>().add(const FetchUserProfile());
        showSuccessMessage(
          context: context,
          content: serverMsg ?? context.localizations.otpVerifiedSuccessfully,
        );
        context.go('/home');
      } else {
        showSuccessMessage(
          context: context,
          content: serverMsg ??
              (isMobile
                  ? context.localizations.mobileVerified
                  : context.localizations.emailVerified),
        );

        // If the other field already has 6 digits, proceed to verify it automatically!
        if (isMobile &&
            !_isEmailVerified &&
            _emailOtpController.text.trim().length == 6) {
          _verifyOtp(type: 'email', otp: _emailOtpController.text.trim());
        } else if (!isMobile &&
            !_isMobileVerified &&
            _mobileOtpController.text.trim().length == 6) {
          _verifyOtp(type: 'mobile', otp: _mobileOtpController.text.trim());
        }
      }
    } catch (error) {
      if (!mounted) return;
      showErrorMessage(context: context, content: _getErrorMessage(error));
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  Future<void> _resendOtp({required String type}) async {
    final isMobile = type == 'mobile';
    if (isMobile ? _isResendingMobile : _isResendingEmail) return;
    if (isMobile ? _isMobileVerified : _isEmailVerified) return;

    final token = isMobile ? widget.mobileToken : widget.emailToken;
    if (token.isEmpty) {
      showErrorMessage(
        context: context,
        content: "Session token is missing. Please register again.",
      );
      return;
    }

    setState(() {
      if (isMobile) {
        _isResendingMobile = true;
      } else {
        _isResendingEmail = true;
      }
    });

    try {
      final authRepo = RepositoryProvider.of<AuthRepository>(context);
      final responseData =
          await authRepo.resendRegistrationOtp(token: token, type: type);

      if (!mounted) return;
      final serverMsg = responseData is Map<String, dynamic>
          ? responseData['message'] as String?
          : null;
      showSuccessMessage(
        context: context,
        content: serverMsg ?? context.localizations.successfullyResentCode,
      );

      _startTimer(isMobile: isMobile);
    } catch (error) {
      if (!mounted) return;
      showErrorMessage(context: context, content: _getErrorMessage(error));
    } finally {
      if (mounted) {
        setState(() {
          if (isMobile) {
            _isResendingMobile = false;
          } else {
            _isResendingEmail = false;
          }
        });
      }
    }
  }

  String _getErrorMessage(Object error) =>
      formatErrorMessage(error, context.localizations);

  void _startTimer({required bool isMobile}) {
    if (isMobile) {
      _mobileTimer?.cancel();
      _mobileRemainingSeconds = 60;
      if (mounted) setState(() {});
      _mobileTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_mobileRemainingSeconds > 1) {
          setState(() => _mobileRemainingSeconds--);
        } else {
          timer.cancel();
          setState(() => _mobileRemainingSeconds = 0);
        }
      });
    } else {
      _emailTimer?.cancel();
      _emailRemainingSeconds = 60;
      if (mounted) setState(() {});
      _emailTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (_emailRemainingSeconds > 1) {
          setState(() => _emailRemainingSeconds--);
        } else {
          timer.cancel();
          setState(() => _emailRemainingSeconds = 0);
        }
      });
    }
  }

  void _onVerifyPressed() {
    final mobileOtp = _mobileOtpController.text.trim();
    final emailOtp = _emailOtpController.text.trim();

    if (!_isMobileVerified && mobileOtp.length != 6) {
      showErrorMessage(
        context: context,
        content: context.localizations.pleaseEnterMobileOtp,
      );
      return;
    }

    if (!_isEmailVerified && emailOtp.length != 6) {
      showErrorMessage(
        context: context,
        content: context.localizations.pleaseEnterEmailOtp,
      );
      return;
    }

    if (!_isMobileVerified) {
      _verifyOtp(type: 'mobile', otp: mobileOtp);
    } else if (!_isEmailVerified) {
      _verifyOtp(type: 'email', otp: emailOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.localizations;

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: CustomAppBar(
        showLeading: true,
        color: context.colorScheme.surface,
      ),
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.all(Spacing.large),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTitle(title: localizations.otpVerificationTitle),
                  const Gap(Spacing.xxxLarge),

                  // Mobile OTP Section
                  Text(
                    localizations.codeWillBeSentTo(widget.mobile),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(Spacing.small),
                  CommonTextField(
                    controller: _mobileOtpController,
                    keyboardType: TextInputType.number,
                    readOnly: _isMobileVerified,
                    maxLength: 6,
                    counterText: '',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    hintText: localizations.mobileVerificationCode,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 48,
                      maxWidth: 100,
                      maxHeight: 48,
                    ),
                    suffixIcon: _isMobileVerified
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            ),
                          )
                        : _isResendingMobile
                        ? const Center(
                            child: SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : _mobileRemainingSeconds > 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${_mobileRemainingSeconds}s',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () => _resendOtp(type: 'mobile'),
                            child: Text(
                              localizations.resendLabel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ),
                  ),

                  const Gap(Spacing.large),

                  // Email OTP Section
                  Text(
                    localizations.codeWillBeSentTo(widget.email),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Gap(Spacing.small),
                  CommonTextField(
                    controller: _emailOtpController,
                    keyboardType: TextInputType.number,
                    readOnly: _isEmailVerified,
                    maxLength: 6,
                    counterText: '',
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    hintText: localizations.emailVerificationCode,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 48,
                      maxWidth: 100,
                      maxHeight: 48,
                    ),
                    suffixIcon: _isEmailVerified
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            ),
                          )
                        : _isResendingEmail
                        ? const Center(
                            child: SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : _emailRemainingSeconds > 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${_emailRemainingSeconds}s',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () => _resendOtp(type: 'email'),
                            child: Text(
                              localizations.resendLabel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ),
                  ),

                  const Gap(Spacing.xxLarge),

                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButtonPrimaryStyle(
                        context,
                        buttonColor: context.colorScheme.primary,
                      ),
                      onPressed: _isVerifying ? null : _onVerifyPressed,
                      child: _isVerifying
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(localizations.verifyButtonLabel),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
