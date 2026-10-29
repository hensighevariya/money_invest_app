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

class GetCurrentUser extends UserProfileEvent {
  const GetCurrentUser();
}

class UpdateNotificationStatus extends UserProfileEvent {
  const UpdateNotificationStatus(this.isNotification);

  final bool isNotification;
}

class UpdateUserProfile extends UserProfileEvent {
  const UpdateUserProfile({
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.address,
    this.pincode,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
  });

  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final String? pincode;
  final String? countryId;
  final String? countryName;
  final String? stateId;
  final String? stateName;
  final String? cityId;
  final String? cityName;
}
