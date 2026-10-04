import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

abstract base class BaseLoginRequest extends Equatable {
  const BaseLoginRequest({required this.pushToken, required this.deviceName});

  final String? pushToken;
  final String? deviceName;

  @override
  List<Object?> get props => [pushToken, deviceName];
}

@JsonSerializable()
final class LoginRequest extends BaseLoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
    required super.pushToken,
    required super.deviceName,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password, pushToken, deviceName];

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
