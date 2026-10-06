import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_navigation_data_model.g.dart';

@JsonSerializable()
class AuthNavigationDataModel extends Equatable {
  final String? token;
  final bool? resetByMobile;
  final String? emailMobileInput;
  final bool? isFromEditProfile;
  final int? type;
  final int? verifyType;

  const AuthNavigationDataModel({
    this.resetByMobile,
    this.emailMobileInput,
    this.token,
    this.isFromEditProfile,
    this.verifyType,
    this.type,
  });

  factory AuthNavigationDataModel.fromJson(Map<String, dynamic> json) =>
      _$AuthNavigationDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthNavigationDataModelToJson(this);

  @override
  List<Object?> get props => [
    resetByMobile,
    emailMobileInput,
    token,
    isFromEditProfile,
  ];
}
