import 'package:equatable/equatable.dart';

typedef PhoneDetail = ({String code, int maxLength, int minLength});

class Country extends Equatable {
  const Country({
    required this.name,
    required this.isoCode,
    required this.iso3Code,
    required this.phoneDetail,
    required this.translations,
  });

  final String name;
  final String isoCode;
  final String iso3Code;
  final PhoneDetail phoneDetail;
  final Map<String, String> translations;

  @override
  List<Object?> get props => [
    name,
    isoCode,
    iso3Code,
    phoneDetail,
    translations,
  ];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isoCode': isoCode,
      'iso3Code': iso3Code,
      'phoneDetail': {
        "code": phoneDetail.code,
        "maxLength": phoneDetail.maxLength,
        "minLength": phoneDetail.minLength,
      },
      'translations': translations,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'] as String,
      isoCode: map['isoCode'] as String,
      iso3Code: map['iso3Code'] as String,
      phoneDetail: (
        code: map['phoneDetail']["code"] as String,
        maxLength: map['phoneDetail']["maxLength"] as int,
        minLength: map['phoneDetail']["minLength"] as int,
      ),
      translations: map['translations'],
    );
  }
}
