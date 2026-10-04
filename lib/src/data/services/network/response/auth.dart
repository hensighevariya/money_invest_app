import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/data/data.dart';

part 'auth.g.dart';

@JsonSerializable()
class AuthSuccessResponse extends Equatable {
  const AuthSuccessResponse({this.message, this.accessToken, this.refreshToken, this.user});

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) => _$AuthSuccessResponseFromJson(json);

  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final UserData? user;

  @override
  List<Object?> get props => [message, accessToken, refreshToken, user];

  Map<String, dynamic> toJson() => _$AuthSuccessResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends Equatable {
  const ForgotPasswordResponse({required this.token, required this.verifyType, required this.type});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgotPasswordResponseFromJson(json);

  final String token;
  final int verifyType;
  final int type;

  @override
  List<Object?> get props => [token, verifyType, type];

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordVerifyResponse extends Equatable {
  const ForgotPasswordVerifyResponse({required this.token});

  factory ForgotPasswordVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordVerifyResponseFromJson(json);

  final String token;

  @override
  List<Object?> get props => [token];

  Map<String, dynamic> toJson() => _$ForgotPasswordVerifyResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class VerifyOtpRequest extends Equatable {
  const VerifyOtpRequest({this.otp, this.token, this.verifyType, this.type, this.preToken, this.loginUserType});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyOtpRequestFromJson(json);

  final String? otp;
  final String? token;
  final String? preToken;
  final int? verifyType;
  final int? type;
  final int? loginUserType;

  @override
  List<Object?> get props => [otp, token, verifyType, type, preToken, loginUserType];

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordRequest extends Equatable {
  const ResetPasswordRequest({
    this.type = 1,
    required this.token,
    required this.password,
    required this.confirmPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestFromJson(json);

  final int type;
  final String token;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [type, token, password, confirmPassword];

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
