import 'package:equatable/equatable.dart';

sealed class ProgressStatus<T> extends Equatable {
  const ProgressStatus();

  @override
  List<Object?> get props => [];

  const factory ProgressStatus.initial() = ProgressStatusInitial<T>;

  const factory ProgressStatus.processing() = ProgressStatusProcessing<T>;

  const factory ProgressStatus.success(T result) = ProgressStatusSuccess<T>;

  const factory ProgressStatus.failed(Object? error) = ProgressStatusFailed<T>;
}

class ProgressStatusInitial<T> extends ProgressStatus<T> {
  const ProgressStatusInitial();
}

class ProgressStatusProcessing<T> extends ProgressStatus<T> {
  const ProgressStatusProcessing();
}

class ProgressStatusSuccess<T> extends ProgressStatus<T> {
  const ProgressStatusSuccess(this.result);

  final T result;

  @override
  List<Object?> get props => [result];
}

class ProgressStatusFailed<T> extends ProgressStatus<T> {
  const ProgressStatusFailed(this.error);

  final Object? error;

  @override
  List<Object?> get props => [error];
}
