import 'dart:async';

import 'package:money_invest_app/src/core/base/base_cubit.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

import 'otp_verification_state.dart';

base class OtpVerificationCubit extends BaseCubit<OtpVerificationState> {
  OtpVerificationCubit({
    required this._authRepository,
    required this._loadingHandler,
    required this.verificationToken,
    required this.emailAddressORMobile,
    required this.type,
    required this.verifyType,
    required this.resetByMobile,
  }) : super(
         OtpVerificationState(
           emailAddressORMobile: emailAddressORMobile,
           resetByMobile: resetByMobile,
           type: type,
           verifyType: verifyType,
           token: verificationToken,
         ),
       ) {
    _startTimer();
  }

  String verificationToken;
  int type;
  int verifyType;
  String emailAddressORMobile;
  bool resetByMobile;
  final AuthRepository _authRepository;
  final LoadingHandler _loadingHandler;
  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _startTimer() {
    Duration duration = const Duration(seconds: 60);
    _updateTimer(duration);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration = duration - const Duration(seconds: 1);
      _updateTimer(duration);
      if (duration == Duration.zero) timer.cancel();
    });
  }

  void _updateTimer(Duration duration) {
    emit(state.copyWith(remainingDuration: duration));
  }

  void onOtpCodeChanged(String value) {
    emit(state.copyWith(otpCodeInput: OtpCodeInput.dirty(value)));
  }

  Future<void> resendOtpCode() async {
    _startTimer();
    try {
      final result = await processRequest(
        () => _authRepository.resendOtp(token: state.token, type: type),
        loadingHandler: _loadingHandler.handleLoading,
      );
      if (result != null) {
        emit(state.copyWith(token: result));
      }
    } catch (error, stackTrace) {
      handleError(error, stackTrace);
    }
  }

  Future<void> onContinue() async {
    if (state.isNotValid) return;

    emit(state.copyWith(status: const ProgressStatus.processing()));
    try {
      OtpVerificationStatusData? statusData;
      final result = await processRequest(
        () => _authRepository.verifyForgotPasswordOtp(
          otpCode: state.otpCodeInput.value,
          token: state.token,
          verifyType: verifyType,
          type: type,
        ),
        loadingHandler: _loadingHandler.handleLoading,
      );
      if (result != null) statusData = OtpVerificationStatusData.token(result, type, verifyType);
      if (statusData != null) {
        emit(state.copyWith(status: ProgressStatus.success(statusData)));
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(status: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}
