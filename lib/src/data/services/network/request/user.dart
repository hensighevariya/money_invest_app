import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UpdateProfileRequest extends Equatable {
  const UpdateProfileRequest({
    required this.fullName,
    required this.dateOfBirth,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  final String fullName;
  final String? dateOfBirth;

  @override
  List<Object?> get props => [fullName, dateOfBirth];

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}

@JsonSerializable()
class ChangePasswordRequest extends SetPasswordRequest {
  const ChangePasswordRequest({
    required this.currentPassword,
    required super.newPassword,
    required super.confirmPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  final String currentPassword;

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}

@JsonSerializable()
class SetPasswordRequest extends Equatable {
  const SetPasswordRequest({
    required this.newPassword,
    required this.confirmPassword,
  });

  factory SetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$SetPasswordRequestFromJson(json);

  final String newPassword;
  final String confirmPassword;

  @override
  List<Object?> get props => [newPassword, confirmPassword];

  Map<String, dynamic> toJson() => _$SetPasswordRequestToJson(this);
}
