import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:money_invest_app/src/utils/log.dart';

class FirebaseService {
  FirebaseService({ this.options, this.vapidKey});

  final FirebaseOptions? options;
  final String? vapidKey;
  final Completer<bool> _initializeCompleter = Completer();

  Future<void> initialize() async {
    return;
    try {
      await Firebase.initializeApp(options: options);
      await FirebaseRemoteConfig.instance.ensureInitialized();
      await FirebaseRemoteConfig.instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 60),
          minimumFetchInterval: const Duration(minutes: 5),
        ),
      );
      await FirebaseRemoteConfig.instance.fetchAndActivate().catchError((Object? error, StackTrace? stackTrace) {
        Log.error(error);
        Log.error(stackTrace);
        return false;
      });

      _initializeCompleter.complete(true);
    } catch (error, stackTrace) {
      _initializeCompleter.completeError(error, stackTrace);
    }
  }

  /*region ---------------------------------------- Messaging ---------------------------------------- */

  Future<String?> getToken() async {
    await _initializeCompleter.future;
    return FirebaseMessaging.instance.getToken();
  }

  Future<void> deleteToken() async {
    await _initializeCompleter.future;
    return FirebaseMessaging.instance.deleteToken();
  }

  Future<RemoteMessage?> getInitialMessage() async {
    await _initializeCompleter.future;
    return FirebaseMessaging.instance.getInitialMessage();
  }

  Stream<RemoteMessage> getOnMessageStream() {
    return FirebaseMessaging.onMessage;
  }

  Stream<RemoteMessage> getOnMessageOpenedAppStream() {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  //endregion

  /*region ---------------------------------------- Remote Config ---------------------------------------- */

  Future<String> getConfigString(String key) async {
    await _initializeCompleter.future;
    return FirebaseRemoteConfig.instance.getString(key);
  }

  //endregion
}

class FirebaseTokenException extends Error {
  FirebaseTokenException();
}
