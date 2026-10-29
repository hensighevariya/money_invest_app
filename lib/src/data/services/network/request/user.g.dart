// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  countryId: json['countryId'] as String?,
  stateId: json['stateId'] as String?,
  cityId: json['cityId'] as String?,
  address: json['address'] as String?,
  pincode: json['pincode'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
    'lastName': instance.lastName,
  };
  if (instance.countryId != null) val['countryId'] = instance.countryId;
  if (instance.stateId != null) val['stateId'] = instance.stateId;
  if (instance.cityId != null) val['cityId'] = instance.cityId;
  if (instance.address != null) val['address'] = instance.address;
  if (instance.pincode != null) val['pincode'] = instance.pincode;
  return val;
}

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
