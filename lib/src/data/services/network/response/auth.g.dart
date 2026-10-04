// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSuccessResponse _$AuthSuccessResponseFromJson(Map<String, dynamic> json) =>
    AuthSuccessResponse(
      message: json['message'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthSuccessResponseToJson(
  AuthSuccessResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'user': instance.user,
};

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResponse(
  token: json['token'] as String,
  verifyType: (json['verifyType'] as num).toInt(),
  type: (json['type'] as num).toInt(),
);

Map<String, dynamic> _$ForgotPasswordResponseToJson(
  ForgotPasswordResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'verifyType': instance.verifyType,
  'type': instance.type,
};

ForgotPasswordVerifyResponse _$ForgotPasswordVerifyResponseFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordVerifyResponse(token: json['token'] as String);

Map<String, dynamic> _$ForgotPasswordVerifyResponseToJson(
  ForgotPasswordVerifyResponse instance,
) => <String, dynamic>{'token': instance.token};

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      otp: json['otp'] as String?,
      token: json['token'] as String?,
      verifyType: (json['verifyType'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      preToken: json['preToken'] as String?,
      loginUserType: (json['loginUserType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'otp': ?instance.otp,
      'token': ?instance.token,
      'preToken': ?instance.preToken,
      'verifyType': ?instance.verifyType,
      'type': ?instance.type,
      'loginUserType': ?instance.loginUserType,
    };

ResetPasswordRequest _$ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  type: (json['type'] as num?)?.toInt() ?? 1,
  token: json['token'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
  'type': instance.type,
  'token': instance.token,
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
};
