import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:money_invest_app/src/utils/log.dart';

class FirebaseService {
  FirebaseService({this.options, this.vapidKey});

  final FirebaseOptions? options;
  final String? vapidKey;
  final Completer<bool> _initializeCompleter = Completer();

  Future<void> initialize() async {
    if (options == null) {
      if (!_initializeCompleter.isCompleted) {
        _initializeCompleter.complete(false);
      }
      return;
    }
    try {
      await Firebase.initializeApp(options: options);
      await FirebaseRemoteConfig.instance.ensureInitialized();
      await FirebaseRemoteConfig.instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 60),
          minimumFetchInterval: const Duration(minutes: 5),
        ),
      );
      await FirebaseRemoteConfig.instance.fetchAndActivate().catchError((
        Object? error,
        StackTrace? stackTrace,
      ) {
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
    try {
      if (Firebase.apps.isEmpty) return null;
      if (!_initializeCompleter.isCompleted) return null;
      final initialized = await _initializeCompleter.future;
      if (!initialized) return null;
      return await FirebaseMessaging.instance.getToken();
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace);
      return null;
    }
  }

  Future<void> deleteToken() async {
    try {
      if (Firebase.apps.isEmpty) return;
      if (!_initializeCompleter.isCompleted) return;
      final initialized = await _initializeCompleter.future;
      if (!initialized) return;
      await FirebaseMessaging.instance.deleteToken();
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace);
    }
  }

  Future<RemoteMessage?> getInitialMessage() async {
    try {
      if (Firebase.apps.isEmpty) return null;
      if (!_initializeCompleter.isCompleted) return null;
      final initialized = await _initializeCompleter.future;
      if (!initialized) return null;
      return await FirebaseMessaging.instance.getInitialMessage();
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace);
      return null;
    }
  }

  Stream<RemoteMessage> getOnMessageStream() {
    try {
      if (Firebase.apps.isEmpty) return const Stream.empty();
      return FirebaseMessaging.onMessage;
    } catch (_) {
      return const Stream.empty();
    }
  }

  Stream<RemoteMessage> getOnMessageOpenedAppStream() {
    try {
      if (Firebase.apps.isEmpty) return const Stream.empty();
      return FirebaseMessaging.onMessageOpenedApp;
    } catch (_) {
      return const Stream.empty();
    }
  }

  //endregion

  /*region ---------------------------------------- Remote Config ---------------------------------------- */

  Future<String> getConfigString(String key) async {
    try {
      if (Firebase.apps.isEmpty) return '';
      if (!_initializeCompleter.isCompleted) return '';
      final initialized = await _initializeCompleter.future;
      if (!initialized) return '';
      return FirebaseRemoteConfig.instance.getString(key);
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace);
      return '';
    }
  }

  //endregion
}

class FirebaseTokenException extends Error {
  FirebaseTokenException();
}
