import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money_invest_app/src/utils/constants.dart';

part 'common.g.dart';

@JsonSerializable()
class PaginationRequest extends Equatable {
  const PaginationRequest({required this.page, this.limit = AppConstants.pageSize});

  factory PaginationRequest.fromJson(Map<String, dynamic> json) => _$PaginationRequestFromJson(json);

  final int page;
  final int limit;

  @override
  List<Object?> get props => [page, limit];

  Map<String, dynamic> toJson() => _$PaginationRequestToJson(this);
}

