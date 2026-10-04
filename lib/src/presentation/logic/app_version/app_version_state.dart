import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';

final class AppVersionState extends DataState<AppVersionData> {
  const AppVersionState({
    super.data,
    super.error,
    super.loading,
    this.updateStatus = AppUpdateStatus.upToDate,
  });

  final AppUpdateStatus updateStatus;

  @override
  List<Object?> get props => super.props..add(updateStatus);

  @override
  AppVersionState copyWith({
    bool? loading,
    AppVersionData? data,
    Object? error,
    AppUpdateStatus? updateStatus,
  }) {
    return AppVersionState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      updateStatus: updateStatus ?? this.updateStatus,
    );
  }
}
