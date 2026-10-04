import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryData extends Equatable {
  final int id;
  final String name;

  const CountryData({required this.id, required this.name});

  factory CountryData.fromJson(Map<String, dynamic> json) => _$CountryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDataToJson(this);

  @override
  List<Object?> get props => [id, name];
}
