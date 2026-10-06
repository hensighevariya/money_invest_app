import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/form_inputs.dart';

class OtpVerificationStatusData {
  final String? token;
  final UserData? userData;
  final int type;
  final int verifyType;

  OtpVerificationStatusData({
    this.userData,
    this.token,
    required this.verifyType,
    required this.type,
  });

  OtpVerificationStatusData.userData(this.userData, this.type, this.verifyType)
    : token = null;

  OtpVerificationStatusData.token(this.token, this.type, this.verifyType)
    : userData = null;
}

class OtpVerificationState extends Equatable with FormzMixin {
  const OtpVerificationState({
    required this.emailAddressORMobile,
    required this.resetByMobile,
    this.otpCodeInput = const OtpCodeInput.pure(),
    this.status = const ProgressStatus.initial(),
    this.remainingDuration = const Duration(seconds: 60),
    required this.type,
    required this.verifyType,
    required this.token,
  });

  final String emailAddressORMobile;
  final bool resetByMobile;
  final OtpCodeInput otpCodeInput;
  final ProgressStatus<OtpVerificationStatusData> status;
  final Duration remainingDuration;
  final int type;
  final int verifyType;
  final String token;

  @override
  List<Object?> get props => [
    emailAddressORMobile,
    resetByMobile,
    otpCodeInput,
    status,
    remainingDuration,
    type,
    verifyType,
    token,
  ];

  @override
  List<FormzInput<Object, Object>> get inputs => [otpCodeInput];

  OtpVerificationState copyWith({
    String? emailAddressORMobile,
    bool? resetByMobile,
    OtpCodeInput? otpCodeInput,
    ProgressStatus<OtpVerificationStatusData>? status,
    Duration? remainingDuration,
    int? type,
    int? verifyType,
    String? token,
  }) {
    return OtpVerificationState(
      emailAddressORMobile: emailAddressORMobile ?? this.emailAddressORMobile,
      resetByMobile: resetByMobile ?? this.resetByMobile,
      otpCodeInput: otpCodeInput ?? this.otpCodeInput,
      status: status ?? this.status,
      remainingDuration: remainingDuration ?? this.remainingDuration,
      type: type ?? this.type,
      verifyType: verifyType ?? this.verifyType,
      token: token ?? this.token,
    );
  }
}
