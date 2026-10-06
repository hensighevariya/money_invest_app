import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

abstract interface class AppConstants {
  static final emailPatternRegExp = RegExp(
    r'^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.(com|co|in)$',
    caseSensitive: false,
  );
  static final namePatternRegExp = RegExp(r'^[\p{L}\s.]+$', unicode: true);
  static final numbersOnlyRegExp = RegExp(r'^\d+$');
  static final alphabetsOnlyRegExp = RegExp(r'[a-zA-Z\s]');
  static final containsAtLeastOneLetter = RegExp(r'\p{L}', unicode: true);

  static final passwordPatternRegExp = RegExp(
    r'^.*(?=.{8,255})((?=.*[!@#$%^&*_,.?’:;"]))(?=.*\d)((?=.*[A-Z]))((?=.*[a-z])).*$',
  );
  static final isOnlyDigits = RegExp(r'^-?[0-9]+$');

  static const pageSize = 10;

  static const localDateFormat = 'dd/MM/yyyy';
  static const localTimeFormat = 'hh:mm a';
  static const localDateTimeFormat = '$localDateFormat $localTimeFormat';
  static const dateOfBirthFormat = 'yyyy/MM/dd';
  static const transactionsDateFormat = 'MMM dd, yyyy';
  static const supportDateFormat = 'MMM dd, yyyy';

  static const String playStoreUniversalLink = '';
  static const String appStoreUniversalLink = '';

  static const String playStoreDeepLink = '';
  static const String appStoreDeepLink = '';

  static Future<String?> get getDeviceUniqueName async {
    String? deviceIdentifier = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
      deviceIdentifier = '${webInfo.browserName.name} - ${webInfo.userAgent}';
    } else {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceIdentifier = '${androidInfo.manufacturer}${androidInfo.model}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceIdentifier = '${iosInfo.name}${iosInfo.model}';
      }
    }
    return deviceIdentifier;
  }
}

abstract class SupportTicketEvent {
  static const String supportSendMsg = 'supportSendMessage';
  static const String closeTicket = 'closeTicket';
  static const String joinSupportChat = 'joinSupportChat';
  static const String leaveSupportChat = 'leaveSupportChat';
}

abstract class SocketEvent {
  static const String forceLogout = 'forceLogout';
  static const String notificationCount = 'notificationCount';
  static const String roleUpdated = 'roleUpdated';
  static const String getActiveSosAlerts = 'getActiveSosAlerts';
}

abstract class SocketOnEvent {
  static const String sosAlert = 'sosAlert';
}
