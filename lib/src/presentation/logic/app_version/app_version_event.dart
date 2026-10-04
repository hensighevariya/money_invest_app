import 'package:flutter/foundation.dart';

@immutable
sealed class AppVersionEvent {
  const AppVersionEvent();
}

class FetchAppVersion extends AppVersionEvent {
  const FetchAppVersion();
}

class CheckAppVersion extends AppVersionEvent {
  const CheckAppVersion();
}
