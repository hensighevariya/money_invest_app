// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  type: (json['type'] as num).toInt(),
  email: json['email'] as String?,
  mobile: json['mobile'] as String?,
  password: json['password'] as String,
  pushToken: json['pushToken'] as String?,
  deviceId: json['deviceId'] as String?,
  deviceType: json['deviceType'] as String,
  otp: json['otp'] as String?,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'pushToken': ?instance.pushToken,
      'deviceId': ?instance.deviceId,
      'type': instance.type,
      'email': ?instance.email,
      'mobile': ?instance.mobile,
      'password': instance.password,
      'deviceType': instance.deviceType,
      'otp': ?instance.otp,
    };

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequest(
  email: json['email'] as String?,
  type: (json['type'] as num?)?.toInt() ?? 1,
  mobile: json['mobile'] as String?,
);

Map<String, dynamic> _$ForgotPasswordRequestToJson(
  ForgotPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'mobile': instance.mobile,
  'type': instance.type,
};
