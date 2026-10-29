import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UpdateProfileRequest extends Equatable {
  const UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    this.countryId,
    this.stateId,
    this.cityId,
    this.address,
    this.pincode,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  final String firstName;
  final String lastName;
  final String? countryId;
  final String? stateId;
  final String? cityId;
  final String? address;
  final String? pincode;

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    countryId,
    stateId,
    cityId,
    address,
    pincode,
  ];

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
