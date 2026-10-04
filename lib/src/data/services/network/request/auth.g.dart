// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
  email: json['email'] as String,
  password: json['password'] as String,
  pushToken: json['pushToken'] as String?,
  deviceName: json['deviceName'] as String?,
);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'pushToken': instance.pushToken,
      'deviceName': instance.deviceName,
      'email': instance.email,
      'password': instance.password,
    };
