import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/data/data.dart';

part 'auth.g.dart';

@JsonSerializable()
class AuthSuccessResponse extends Equatable {
  const AuthSuccessResponse({
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
    this.token,
  });

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) {
    final res = _$AuthSuccessResponseFromJson(json);
    final resolvedToken =
        res.accessToken ?? res.token ?? (json['token'] as String?);
    return AuthSuccessResponse(
      message: res.message,
      accessToken: resolvedToken,
      refreshToken: res.refreshToken,
      user: res.user,
      token: resolvedToken,
    );
  }

  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final UserData? user;
  final String? token;

  @override
  List<Object?> get props => [message, accessToken, refreshToken, user, token];

  Map<String, dynamic> toJson() => _$AuthSuccessResponseToJson(this);
}

@JsonSerializable(createFactory: false)
class ForgotPasswordResponse extends Equatable {
  const ForgotPasswordResponse({
    this.token = '',
    this.verifyType = 0,
    this.type = 0,
    this.message,
    this.resetToken,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    final token = (json['token'] ?? json['resetToken'] ?? json['verificationToken'] ?? '').toString();
    final message = json['message']?.toString();
    final verifyType = json['verifyType'] is int
        ? json['verifyType'] as int
        : int.tryParse(json['verifyType']?.toString() ?? '') ?? 0;
    final type = json['type'] is int
        ? json['type'] as int
        : int.tryParse(json['type']?.toString() ?? '') ?? 0;
    return ForgotPasswordResponse(
      token: token,
      verifyType: verifyType,
      type: type,
      message: message,
      resetToken: json['resetToken']?.toString(),
    );
  }

  factory ForgotPasswordResponse.fromData(dynamic data) {
    if (data is String) {
      return ForgotPasswordResponse(token: data);
    }
    if (data is Map<String, dynamic>) {
      return ForgotPasswordResponse.fromJson(data);
    }
    return const ForgotPasswordResponse();
  }

  final String token;
  final int verifyType;
  final int type;
  final String? message;
  final String? resetToken;

  @override
  List<Object?> get props => [token, verifyType, type, message, resetToken];

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable(createFactory: false)
class ForgotPasswordVerifyResponse extends Equatable {
  const ForgotPasswordVerifyResponse({
    required this.token,
    this.resetToken,
    this.message,
  });

  factory ForgotPasswordVerifyResponse.fromJson(Map<String, dynamic> json) {
    final resetToken = (json['resetToken'] ?? json['token'] ?? '').toString();
    return ForgotPasswordVerifyResponse(
      token: (json['token'] ?? resetToken).toString(),
      resetToken: resetToken.isNotEmpty ? resetToken : null,
      message: json['message']?.toString(),
    );
  }

  factory ForgotPasswordVerifyResponse.fromData(dynamic data) {
    if (data is String) {
      return ForgotPasswordVerifyResponse(token: data, resetToken: data);
    }
    if (data is Map<String, dynamic>) {
      return ForgotPasswordVerifyResponse.fromJson(data);
    }
    return const ForgotPasswordVerifyResponse(token: '');
  }

  final String token;
  final String? resetToken;
  final String? message;

  @override
  List<Object?> get props => [token, resetToken, message];

  Map<String, dynamic> toJson() => _$ForgotPasswordVerifyResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class VerifyOtpRequest extends Equatable {
  const VerifyOtpRequest({
    this.otp,
    this.token,
    this.verifyType,
    this.type,
    this.preToken,
    this.loginUserType,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  final String? otp;
  final String? token;
  final String? preToken;
  final int? verifyType;
  final int? type;
  final int? loginUserType;

  @override
  List<Object?> get props => [
    otp,
    token,
    verifyType,
    type,
    preToken,
    loginUserType,
  ];

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable(includeIfNull: false, createToJson: false)
class ResetPasswordRequest extends Equatable {
  const ResetPasswordRequest({
    required this.resetToken,
    required this.newPassword,
    required this.confirmPassword,
    this.token,
    this.password,
    this.type,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  final String resetToken;
  final String newPassword;
  final String confirmPassword;
  final String? token;
  final String? password;
  final int? type;

  @override
  List<Object?> get props => [
    resetToken,
    newPassword,
    confirmPassword,
    token,
    password,
    type,
  ];

  Map<String, dynamic> toJson() => {
    'resetToken': resetToken,
    'newPassword': newPassword,
    'confirmPassword': confirmPassword,
  };
}
