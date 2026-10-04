import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

const dateField = JsonKey(fromJson: parseUtcDateTime, toJson: toUtcDateTimeString);
const dateFieldNullable = JsonKey(fromJson: parseUtcDateTimeNullable, toJson: toUtcDateTimeStringNullable);
const createdAtField = JsonKey(name: 'createdAt', fromJson: parseUtcDateTime, toJson: toUtcDateTimeString);
const updatedAtField = JsonKey(name: 'updatedAt', fromJson: parseUtcDateTime, toJson: toUtcDateTimeString);
const idField = JsonKey(name: '_id');

final _utcDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

DateTime parseUtcDateTime(String value) {
  return _utcDateTimeFormat.parseUtc(value.replaceAll('T', ' ').replaceAll('Z', ' ').trim());
}

String toUtcDateTimeString(DateTime value) {
  return _utcDateTimeFormat.format(value);
}

DateTime? parseUtcDateTimeNullable(String? value) {
  if (value == null) return null;
  return _utcDateTimeFormat.tryParseUtc(value.replaceAll('T', ' ').replaceAll('Z', ' ').trim());
}

String? toUtcDateTimeStringNullable(DateTime? value) {
  return value == null ? null : _utcDateTimeFormat.format(value);
}

abstract base class BaseEntity with EquatableMixin {
  const BaseEntity({required this.id});

  @idField
  final String id;

  @override
  List<Object?> get props => [id];
}
