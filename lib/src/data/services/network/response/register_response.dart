import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/data/data.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse extends Equatable {
  const RegisterResponse({
    this.message,
    this.accessToken,
    this.refreshToken,
    this.user,
    this.token,
    this.status,
    this.emailVerificationToken,
    this.mobileVerificationToken,
    this.emailOtp,
    this.mobileOtp,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final UserData? user;
  final String? token;
  final dynamic status;
  final String? emailVerificationToken;
  final String? mobileVerificationToken;
  final String? emailOtp;
  final String? mobileOtp;

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  @override
  List<Object?> get props => [
    message,
    accessToken,
    refreshToken,
    user,
    token,
    status,
    emailVerificationToken,
    mobileVerificationToken,
    emailOtp,
    mobileOtp,
  ];
}
