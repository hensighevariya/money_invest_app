import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/core/base/base_entity.dart';
import 'package:money_invest_app/src/core/core.dart';

part 'user_model.g.dart';

@JsonSerializable()
final class UserData extends BaseEntity {
  const UserData({
    required super.id,
    this.uid = '',
    this.fullName = '',
    this.email = '',
    this.dateOfBirth,
    this.referralCode = '',
    this.hasPassword = false,
    this.isSubscriptions = false,
    this.isEmailVerified = false,
    this.isGenreAdded = false,
    this.clientId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.isNotification = false,
    this.role,
    this.isKyc = 0,
    this.monthlyReturn = 0,
    this.walletBalance = 0,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final id = (json['_id'] ?? json['id'] ?? '').toString();
    final map = {
      ...json,
      '_id': id,
    };
    return _$UserDataFromJson(map);
  }

  final String uid;
  final String fullName;
  final String email;
  final String? dateOfBirth;
  @JsonKey(name: 'referalCode')
  final String referralCode;
  @JsonKey(name: 'hasPasssword')
  final bool hasPassword;
  final bool isSubscriptions;
  final bool isEmailVerified;
  final bool isGenreAdded;
  final String? clientId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final bool isNotification;
  final String? role;
  final num isKyc;
  final num monthlyReturn;
  final num walletBalance;
  final String? createdAt;

  @override
  List<Object?> get props => [
    id,
    uid,
    fullName,
    email,
    dateOfBirth,
    referralCode,
    hasPassword,
    isSubscriptions,
    isEmailVerified,
    isGenreAdded,
    clientId,
    firstName,
    lastName,
    phoneNumber,
    isNotification,
    role,
    isKyc,
    monthlyReturn,
    walletBalance,
    createdAt,
  ];

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  UserData copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? dateOfBirth,
    String? referralCode,
    bool? hasPassword,
    bool? isSubscriptions,
    bool? isEmailVerified,
    bool? isGenreAdded,
    String? clientId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? isNotification,
    String? role,
    num? isKyc,
    num? monthlyReturn,
    num? walletBalance,
    String? createdAt,
  }) {
    return UserData(
      id: id,
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      referralCode: referralCode ?? this.referralCode,
      hasPassword: hasPassword ?? this.hasPassword,
      isSubscriptions: isSubscriptions ?? this.isSubscriptions,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isGenreAdded: isGenreAdded ?? this.isGenreAdded,
      clientId: clientId ?? this.clientId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isNotification: isNotification ?? this.isNotification,
      role: role ?? this.role,
      isKyc: isKyc ?? this.isKyc,
      monthlyReturn: monthlyReturn ?? this.monthlyReturn,
      walletBalance: walletBalance ?? this.walletBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
