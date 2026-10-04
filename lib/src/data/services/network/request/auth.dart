import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

abstract base class BaseLoginRequest extends Equatable {
  const BaseLoginRequest({required this.pushToken, required this.deviceId});

  final String? pushToken;
  final String? deviceId;

  @override
  List<Object?> get props => [pushToken, deviceId];
}

@JsonSerializable(includeIfNull: false)
final class LoginRequest extends BaseLoginRequest {
  const LoginRequest({
    required this.type,
    this.email,
    this.mobile,
    required this.password,
    required super.pushToken,
    required super.deviceId,
    required this.deviceType,
    this.otp,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  final int type; // 1: Mobile, 2: Email
  final String? email;
  final String? mobile;
  final String password;
  final String deviceType;
  final String? otp;

  @override
  List<Object?> get props => [type, email, password, pushToken, deviceId, deviceType, otp];

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class ForgotPasswordRequest extends Equatable {
  const ForgotPasswordRequest({this.email, this.type = 1, this.mobile});

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => _$ForgotPasswordRequestFromJson(json);

  final String? email;
  final String? mobile;
  final int type;

  @override
  List<Object?> get props => [email, type, mobile];

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
