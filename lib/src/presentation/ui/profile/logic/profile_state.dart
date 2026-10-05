import 'package:equatable/equatable.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';

class ProfileState extends Equatable {
  final bool isNotification;
  final ProgressStatus<bool> logoutStatus;

  @override
  List<Object?> get props => [isNotification, logoutStatus];

  const ProfileState({this.isNotification = false, this.logoutStatus = const ProgressStatus.initial()});

  ProfileState copyWith({bool? isNotification, ProgressStatus<bool>? logoutStatus}) {
    return ProfileState(
      isNotification: isNotification ?? this.isNotification,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }
}
