sealed class ProfileEvent {}

final class UserLogoutRequested extends ProfileEvent {
  UserLogoutRequested();
}

final class NotificationStatusChanged extends ProfileEvent {
  NotificationStatusChanged(this.isNotification);

  final bool isNotification;
}
