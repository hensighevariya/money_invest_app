import 'package:flutter/foundation.dart';
import 'package:money_invest_app/src/data/data.dart';

@immutable
sealed class UserProfileEvent {
  const UserProfileEvent();
}

class FetchUserProfile extends UserProfileEvent {
  const FetchUserProfile();
}

class UserProfileUpdated extends UserProfileEvent {
  const UserProfileUpdated(this.userData);

  final UserData? userData;
}

class UserLoggedIn extends UserProfileEvent {
  const UserLoggedIn(this.userData);

  final UserData userData;
}

class UserLoggedOut extends UserProfileEvent {
  const UserLoggedOut();
}
