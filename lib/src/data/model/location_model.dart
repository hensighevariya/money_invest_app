import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(createFactory: false)
class LocationCountry extends Equatable {
  const LocationCountry({
    required this.id,
    required this.name,
    this.phoneCode,
    this.isoCode,
  });

  factory LocationCountry.fromJson(Map<String, dynamic> json) =>
      LocationCountry(
        id: (json['_id'] ?? json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        phoneCode: json['phoneCode']?.toString(),
        isoCode: (json['isoCode'] ?? json['code'])?.toString(),
      );

  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? phoneCode;
  final String? isoCode;

  Map<String, dynamic> toJson() => _$LocationCountryToJson(this);

  @override
  List<Object?> get props => [id, name, phoneCode, isoCode];
}

@JsonSerializable(createFactory: false)
class LocationState extends Equatable {
  const LocationState({
    required this.id,
    required this.name,
    this.countryId,
  });

  factory LocationState.fromJson(Map<String, dynamic> json) =>
      LocationState(
        id: (json['_id'] ?? json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        countryId: (json['countryId'] ?? json['country'])?.toString(),
      );

  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? countryId;

  Map<String, dynamic> toJson() => _$LocationStateToJson(this);

  @override
  List<Object?> get props => [id, name, countryId];
}

@JsonSerializable(createFactory: false)
class LocationCity extends Equatable {
  const LocationCity({
    required this.id,
    required this.name,
    this.stateId,
    this.countryId,
  });

  factory LocationCity.fromJson(Map<String, dynamic> json) =>
      LocationCity(
        id: (json['_id'] ?? json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        stateId: (json['stateId'] ?? json['state'])?.toString(),
        countryId: (json['countryId'] ?? json['country'])?.toString(),
      );

  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? stateId;
  final String? countryId;

  Map<String, dynamic> toJson() => _$LocationCityToJson(this);

  @override
  List<Object?> get props => [id, name, stateId, countryId];
}
