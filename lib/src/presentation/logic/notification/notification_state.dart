import 'package:equatable/equatable.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class InitialNotificationState extends NotificationState {
  const InitialNotificationState();
}

class UserSubscriptionNotification extends NotificationState {
  const UserSubscriptionNotification();

  @override
  List<Object?> get props => [];
}

class UserPointsPurchaseNotification extends NotificationState {
  const UserPointsPurchaseNotification();

  @override
  List<Object?> get props => [];
}

class PushNotificationData extends Equatable {
  const PushNotificationData({
    required this.title,
    required this.body,
    this.imageUrl,
  });

  final String? title;
  final String? body;
  final String? imageUrl;

  @override
  List<Object?> get props => [title, body, imageUrl];
}
