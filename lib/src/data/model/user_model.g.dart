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
  address: json['address'] as String?,
  pincode: json['pincode'] as String?,
  countryId: json['countryId'] is String
      ? json['countryId'] as String
      : (json['country'] is Map
          ? ((json['country'] as Map)['id'] ?? (json['country'] as Map)['_id'])?.toString()
          : (json['country'] is String ? json['country'] as String : null)),
  countryName: json['countryName'] as String? ??
      (json['country'] is Map ? (json['country'] as Map)['name']?.toString() : null),
  stateId: json['stateId'] is String
      ? json['stateId'] as String
      : (json['state'] is Map
          ? ((json['state'] as Map)['id'] ?? (json['state'] as Map)['_id'])?.toString()
          : (json['state'] is String ? json['state'] as String : null)),
  stateName: json['stateName'] as String? ??
      (json['state'] is Map ? (json['state'] as Map)['name']?.toString() : null),
  cityId: json['cityId'] is String
      ? json['cityId'] as String
      : (json['city'] is Map
          ? ((json['city'] as Map)['id'] ?? (json['city'] as Map)['_id'])?.toString()
          : (json['city'] is String ? json['city'] as String : null)),
  cityName: json['cityName'] as String? ??
      (json['city'] is Map ? (json['city'] as Map)['name']?.toString() : null),
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
  'address': instance.address,
  'pincode': instance.pincode,
  'countryId': instance.countryId,
  'countryName': instance.countryName,
  'stateId': instance.stateId,
  'stateName': instance.stateName,
  'cityId': instance.cityId,
  'cityName': instance.cityName,
  'isNotification': instance.isNotification,
  'role': instance.role,
  'isKyc': instance.isKyc,
  'monthlyReturn': instance.monthlyReturn,
  'walletBalance': instance.walletBalance,
  'createdAt': instance.createdAt,
};
