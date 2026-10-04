// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSuccessResponse _$AuthSuccessResponseFromJson(Map<String, dynamic> json) =>
    AuthSuccessResponse(
      sessionToken: json['sessionToken'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthSuccessResponseToJson(
  AuthSuccessResponse instance,
) => <String, dynamic>{
  'sessionToken': instance.sessionToken,
  'user': instance.user,
};
