import 'package:flutter/material.dart';

import 'country_list.dart';
import 'country_model.dart';

mixin CountryPickerHelper {
  static Country? getCountryByPhoneCode(String phoneCode) {
    try {
      return countryList.firstWhere((country) => country.phoneDetail.code.toLowerCase() == phoneCode.toLowerCase());
    } catch (error) {
      return null;
    }
  }

  static Country? getCountryByIso3Code(String iso3Code) {
    try {
      return countryList.firstWhere((country) => country.iso3Code.toLowerCase() == iso3Code.toLowerCase());
    } catch (error) {
      return null;
    }
  }

  static Country? getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere((country) => country.isoCode.toLowerCase() == isoCode.toLowerCase());
    } catch (error) {
      return null;
    }
  }

  static Country? getCountryByName(String name) {
    try {
      return countryList.firstWhere((country) => country.name.toLowerCase() == name.toLowerCase());
    } catch (error) {
      return null;
    }
  }

  static String getFlagImageAssetPath(String isoCode) => "images/${isoCode.toLowerCase()}.png";

  static Widget getDefaultFlagImage(Country country, {double width = 24.0, double height = 24.0}) {
    return Image.asset(
      getFlagImageAssetPath(country.isoCode),
      height: height,
      width: width,
      fit: BoxFit.cover,
      package: "country_picker",
    );
  }
}
