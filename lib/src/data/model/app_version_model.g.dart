// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionData _$AppVersionDataFromJson(Map<String, dynamic> json) =>
    AppVersionData(
      version: json['version'] as String,
      supportedVersion: json['supportedVersion'] as String,
      buildNumber: (json['buildNumber'] as num).toInt(),
      supportedBuildNumber: (json['supportedBuildNumber'] as num).toInt(),
    );

Map<String, dynamic> _$AppVersionDataToJson(AppVersionData instance) =>
    <String, dynamic>{
      'version': instance.version,
      'supportedVersion': instance.supportedVersion,
      'buildNumber': instance.buildNumber,
      'supportedBuildNumber': instance.supportedBuildNumber,
    };
