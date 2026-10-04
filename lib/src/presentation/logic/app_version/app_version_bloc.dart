import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:common_extensions/common_extensions.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:version/version.dart';

import 'app_version_event.dart';
import 'app_version_state.dart';

final class AppVersionBloc extends BaseBloc<AppVersionEvent, AppVersionState> with HydratedMixin {
  AppVersionBloc({required this._commonRepository})
    : super(const AppVersionState()) {
    hydrate();

    on<FetchAppVersion>(_onFetchAppVersion, transformer: droppable());
    on<CheckAppVersion>(_onCheckAppVersion, transformer: restartable());

    PackageInfo.fromPlatform().then(_packageInfoCompleter.complete).catchError(onError);
  }

  final CommonRepository _commonRepository;
  final Completer<PackageInfo> _packageInfoCompleter = Completer();

  FutureOr<void> _onFetchAppVersion(FetchAppVersion event, Emitter<AppVersionState> emit) async {
    if (state.data != null) add(const CheckAppVersion());

    final result = await processRequestWithRetry(
      _commonRepository.getVersionData,
      loadingHandler: (loading) => emit(state.copyWith(loading: loading)),
      errorHandler: (error, [stackTrace]) => emit(state.copyWith(error: error)),
    );
    if (result != null) {
      emit(state.copyWith(data: result));
      add(const CheckAppVersion());
    } else {
      emit(state.copyWith(updateStatus: AppUpdateStatus.unableToCheck));
    }
  }

  FutureOr<void> _onCheckAppVersion(CheckAppVersion event, Emitter<AppVersionState> emit) async {
    final versionData = state.data;
    if (versionData == null) return;

    final packageInfo = await _packageInfoCompleter.future;

    final buildNumber = packageInfo.buildNumber.toInt();
    final currentAppVersion = Version.parse(packageInfo.version);
    final latestAppVersion = Version.parse(versionData.version);
    final supportedAppVersion = Version.parse(versionData.supportedVersion);

    AppUpdateStatus updateStatus = switch (currentAppVersion) {
      _ when currentAppVersion < supportedAppVersion => AppUpdateStatus.forceUpdate,
      _ when currentAppVersion < latestAppVersion => AppUpdateStatus.updateAvailable,
      _ => switch (buildNumber) {
        _ when buildNumber < versionData.supportedBuildNumber => AppUpdateStatus.forceUpdate,
        _ when buildNumber < versionData.buildNumber => AppUpdateStatus.updateAvailable,
        _ => AppUpdateStatus.upToDate,
      },
    };

    emit(state.copyWith(updateStatus: updateStatus));
  }

  @override
  AppVersionState? fromJson(Map<String, dynamic> json) {
    if (json case {'versionData': Map<String, dynamic> versionDataJson}) {
      return AppVersionState(data: AppVersionData.fromJson(versionDataJson));
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AppVersionState state) {
    return {if (state.data != null) 'versionData': state.data?.toJson()};
  }
}
