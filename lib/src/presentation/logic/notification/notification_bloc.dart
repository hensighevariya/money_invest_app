import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/presentation/logic/notification.dart';
import 'package:money_invest_app/src/utils/log.dart';
import 'package:money_invest_app/src/utils/subscription_mixin.dart';

final class NotificationBloc extends Bloc<NotificationEvent, NotificationState>
    with StreamSubscriptionMixin {
  NotificationBloc({required this._commonRepository})
    : super(const InitialNotificationState()) {
    on<NotificationInitialize>(_onNotificationInitialize);
    on<NotificationReceived>(_onNotificationReceived);
    on<NotificationOpenedApp>(_onNotificationOpenedApp);

    addAllSubscriptions([
      _commonRepository.onRemoveMessage.listen(_onRemoveMessage),
      _commonRepository.onRemoteMessageOpenedApp.listen(
        _onRemoteMessageOpenedApp,
      ),
    ]);
  }

  static const _categoryGeneralNotification = 'security-saas-notifications';
  static const _androidNotificationIcon = '@drawable/ic_notifications';

  final CommonRepository _commonRepository;
  late final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> close() {
    cancelAllSubscriptions();
    return super.close();
  }

  PushNotificationData _getPushNotification(RemoteNotification notification) {
    String? imageUrl;
    if (Platform.isAndroid) imageUrl = notification.android?.imageUrl;
    if (Platform.isIOS) imageUrl = notification.apple?.imageUrl;

    return PushNotificationData(
      title: notification.title,
      body: notification.body,
      imageUrl: imageUrl,
    );
  }

  void _onRemoveMessage(RemoteMessage message) {
    Log.debug('_onFirebaseMessage');
    Log.debug(message.notification?.toMap());
    Log.debug(message.data);

    add(
      NotificationReceived(
        notificationData: message.notification != null
            ? _getPushNotification(message.notification!)
            : null,
        payloadData: message.data,
      ),
    );
  }

  void _onRemoteMessageOpenedApp(RemoteMessage message) {
    Log.debug('_onFirebaseMessageOpenedApp');
    Log.debug(message.notification?.toMap());
    Log.debug(message.data);

    add(
      NotificationOpenedApp(
        notificationData: message.notification != null
            ? _getPushNotification(message.notification!)
            : null,
        payloadData: message.data,
      ),
    );
  }

  void _onDidReceiveNotificationResponse(NotificationResponse event) {
    Log.debug(
      '_onDidReceiveNotificationResponse -> $event -> ${event.payload}',
    );
    if (event.payload == null) return;
    final payloadData = jsonDecode(event.payload!);

    add(
      NotificationOpenedApp(payloadData: payloadData as Map<String, dynamic>),
    );
  }

  Future<bool> _resolveNotificationPermission() async {
    final permissionResult = await PermissionHelper.notification
        .requestPermission();
    return permissionResult == PermissionResult.granted;
  }

  Future<void> _showGeneralNotification({
    required String title,
    String? body,
    Map<String, dynamic> payload = const {},
  }) async {
    final notificationType = payload['notificationType']?.toString();
    final notificationId = payload.hashCode;

    final hasPermission = await _resolveNotificationPermission();
    if (!hasPermission) return;

    final androidDetails = AndroidNotificationDetails(
      _categoryGeneralNotification,
      'General Notifications',
      icon: _androidNotificationIcon,
      groupKey: notificationType,
    );
    const iosDetails = DarwinNotificationDetails(
      categoryIdentifier: _categoryGeneralNotification,
    );
    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    return _notificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: jsonEncode(payload),
    );
  }

  FutureOr<void> _onNotificationInitialize(
    NotificationInitialize event,
    Emitter<NotificationState> emit,
  ) async {
    _commonRepository.initialMessage.then((value) {
      if (value != null) _onRemoteMessageOpenedApp(value);
    });
    const androidSettings = AndroidInitializationSettings(
      _androidNotificationIcon,
    );
    const iosSettings = DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          _categoryGeneralNotification,
          options: {DarwinNotificationCategoryOption.allowAnnouncement},
        ),
      ],
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _categoryGeneralNotification,
            'General Notifications',
          ),
        );
    _notificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value != null &&
          value.didNotificationLaunchApp &&
          value.notificationResponse != null) {
        _onDidReceiveNotificationResponse(value.notificationResponse!);
      }
    });
  }

  void _onNotificationReceived(
    NotificationReceived event,
    Emitter<NotificationState> emit,
  ) {
    if (event.notificationData?.title != null) {
      _showGeneralNotification(
        title: event.notificationData?.title ?? '-',
        body: event.notificationData?.body,
        payload: event.payloadData ?? {},
      );
    }

    if (event.payloadData case {'notificationType': String notificationType}) {
      switch (notificationType) {
        case '1':
          break;
        case '2':
          emit(const UserPointsPurchaseNotification());
          break;
        case '3':
          emit(const UserSubscriptionNotification());
          break;
        default:
          break;
      }
    }
    emit(const InitialNotificationState());
  }

  FutureOr<void> _onNotificationOpenedApp(
    NotificationOpenedApp event,
    Emitter<NotificationState> emit,
  ) {}
}
