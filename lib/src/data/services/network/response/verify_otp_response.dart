import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/data/data.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse extends Equatable {
  const VerifyOtpResponse({
    this.success,
    this.message,
    this.data,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('data') && json['data'] is Map<String, dynamic>) {
      return _$VerifyOtpResponseFromJson(json);
    }
    return VerifyOtpResponse(
      success: json['success'] as bool? ?? true,
      message: json['message'] as String?,
      data: VerifyOtpData.fromJson(json),
    );
  }

  final bool? success;
  final String? message;
  final VerifyOtpData? data;

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);

  @override
  List<Object?> get props => [success, message, data];
}

@JsonSerializable()
class VerifyOtpData extends Equatable {
  const VerifyOtpData({
    this.isCompleted,
    this.verifiedType,
    this.user,
    this.token,
    this.refreshToken,
    this.message,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDataFromJson(json);

  final bool? isCompleted;
  final String? verifiedType;
  final UserData? user;
  final String? token;
  final String? refreshToken;
  final String? message;

  String? get accessToken => token;

  Map<String, dynamic> toJson() => _$VerifyOtpDataToJson(this);

  @override
  List<Object?> get props => [
    isCompleted,
    verifiedType,
    user,
    token,
    refreshToken,
    message,
  ];
}
