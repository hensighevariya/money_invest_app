// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  id: json['_id'] as String,
  uid: json['uid'] as String? ?? '',
  fullName: json['fullName'] as String? ?? '',
  email: json['email'] as String? ?? '',
  dateOfBirth: json['dateOfBirth'] as String?,
  referralCode: json['referalCode'] as String? ?? '',
  hasPassword: json['hasPasssword'] as bool? ?? false,
  isSubscriptions: json['isSubscriptions'] as bool? ?? false,
  isEmailVerified: json['isEmailVerified'] as bool? ?? false,
  isGenreAdded: json['isGenreAdded'] as bool? ?? false,
  clientId: json['clientId'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  isNotification: json['isNotification'] as bool? ?? false,
  role: json['role'] as String?,
  isKyc: json['isKyc'] as num? ?? 0,
  monthlyReturn: json['monthlyReturn'] as num? ?? 0,
  walletBalance: json['walletBalance'] as num? ?? 0,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  '_id': instance.id,
  'uid': instance.uid,
  'fullName': instance.fullName,
  'email': instance.email,
  'dateOfBirth': instance.dateOfBirth,
  'referalCode': instance.referralCode,
  'hasPasssword': instance.hasPassword,
  'isSubscriptions': instance.isSubscriptions,
  'isEmailVerified': instance.isEmailVerified,
  'isGenreAdded': instance.isGenreAdded,
  'clientId': instance.clientId,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'isNotification': instance.isNotification,
  'role': instance.role,
  'isKyc': instance.isKyc,
  'monthlyReturn': instance.monthlyReturn,
  'walletBalance': instance.walletBalance,
  'createdAt': instance.createdAt,
};
