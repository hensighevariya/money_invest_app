import 'package:flutter/foundation.dart';

import 'notification_state.dart';

@immutable
sealed class NotificationEvent {
  const NotificationEvent();
}

class NotificationInitialize extends NotificationEvent {
  const NotificationInitialize();
}

class NotificationReceived extends NotificationEvent {
  const NotificationReceived({
    this.notificationData,
    this.payloadData,
  });

  final PushNotificationData? notificationData;
  final Map<String, dynamic>? payloadData;
}

class NotificationOpenedApp extends NotificationEvent {
  const NotificationOpenedApp({
    this.notificationData,
    this.payloadData,
  });

  final PushNotificationData? notificationData;
  final Map<String, dynamic>? payloadData;
}
