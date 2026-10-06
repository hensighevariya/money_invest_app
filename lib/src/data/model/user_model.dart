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
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

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
    );
  }
}
