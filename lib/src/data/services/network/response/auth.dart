import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/data/data.dart';

part 'auth.g.dart';

@JsonSerializable()
class AuthSuccessResponse extends Equatable {
  const AuthSuccessResponse({required this.sessionToken, required this.user});

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) => _$AuthSuccessResponseFromJson(json);

  final String sessionToken;
  final UserData user;

  @override
  List<Object?> get props => [sessionToken, user];

  Map<String, dynamic> toJson() => _$AuthSuccessResponseToJson(this);
}




