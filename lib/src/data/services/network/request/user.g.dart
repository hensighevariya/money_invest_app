// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  fullName: json['fullName'] as String,
  dateOfBirth: json['dateOfBirth'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'dateOfBirth': instance.dateOfBirth,
};

ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => ChangePasswordRequest(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  ChangePasswordRequest instance,
) => <String, dynamic>{
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
  'currentPassword': instance.currentPassword,
};

SetPasswordRequest _$SetPasswordRequestFromJson(Map<String, dynamic> json) =>
    SetPasswordRequest(
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$SetPasswordRequestToJson(SetPasswordRequest instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
