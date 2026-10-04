// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationRequest _$PaginationRequestFromJson(Map<String, dynamic> json) =>
    PaginationRequest(
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num?)?.toInt() ?? AppConstants.pageSize,
    );

Map<String, dynamic> _$PaginationRequestToJson(PaginationRequest instance) =>
    <String, dynamic>{'page': instance.page, 'limit': instance.limit};
