import 'dart:io';

abstract interface class AppConstants {
  static final emailPatternRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static final passwordPatternRegExp = RegExp(
    r'^.*(?=.{8,255})((?=.*[!@#$%^&*_,.?’:;"]))(?=.*\d)((?=.*[A-Z]))((?=.*[a-z])).*$',
  );
  static final emojiPatternRegExp = RegExp(
    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
  );

  static const pageSize = 20;
  static const chatPageSize = 50;
  static const streamClipsPageSize = 25;

  static const serverDateFormat = 'yyyy-MM-dd';
  static const serverTimeFormat = 'HH:mm:ss';
  static const serverDateTimeFormat = '$serverDateFormat $serverTimeFormat';
  static const localDateFormat = 'dd/MM/yyyy';
  static const localTimeFormat = 'hh:mm a';
  static const localDateTimeFormat = '$localDateFormat $localTimeFormat';
  static const dateOfBirthFormat = 'yyyy/MM/dd';
  static const transactionsDateFormat = 'MMM dd, yyyy';
  static const supportDateFormat = 'MMM dd, yyyy';

  static final shouldUseInAppPurchase = Platform.isIOS;
  static final canManageAppleSubscription = Platform.isIOS;
  static final canManageStripeSubscription = !Platform.isIOS;
  static final shouldProvideAppleLogin = Platform.isIOS;

  static const appleSubscriptionsUrl = 'https://account.apple.com/account/manage/section/subscriptions';

  static const String playStoreUniversalLink = '';
  static const String appStoreUniversalLink = '';

  static const String playStoreDeepLink = '';
  static const String appStoreDeepLink = '';
}
