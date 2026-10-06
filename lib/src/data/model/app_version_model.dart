import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_version_model.g.dart';

@JsonSerializable()
class AppVersionData extends Equatable {
  const AppVersionData({
    required this.version,
    required this.supportedVersion,
    required this.buildNumber,
    required this.supportedBuildNumber,
  });

  factory AppVersionData.fromJson(Map<String, dynamic> json) =>
      _$AppVersionDataFromJson(json);

  final String version;
  final String supportedVersion;
  final int buildNumber;
  final int supportedBuildNumber;

  @override
  List<Object?> get props => [
    version,
    supportedVersion,
    buildNumber,
    supportedBuildNumber,
  ];

  Map<String, dynamic> toJson() => _$AppVersionDataToJson(this);
}

enum AppUpdateStatus { updateAvailable, forceUpdate, upToDate, unableToCheck }
