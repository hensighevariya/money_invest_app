import 'dart:async';

import 'package:common_extensions/common_extensions.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/constants.dart';
import 'package:money_invest_app/src/utils/helper_functions.dart';
import 'package:money_invest_app/src/utils/log.dart';
import '../services/network/request/user.dart';

final class UserRepository extends BaseRepository {
  UserRepository({
    required LocalStorageService localStorageService,
    required ApiClientService apiClientService,
    required FirebaseService firebaseService,
  }) : _localStorageService = localStorageService,
       _apiClientService = apiClientService,
       _firebaseService = firebaseService;
  final LocalStorageService _localStorageService;
  final ApiClientService _apiClientService;
  final FirebaseService _firebaseService;

  final StreamController<UserData?> _userStreamController = StreamController.broadcast();

  @override
  void dispose() {
    _userStreamController.close();
    super.dispose();
  }

  Stream<UserData?> get userStream => _userStreamController.stream;

  void _updateUserData(UserData? userData) {
    _localStorageService.userData = userData;
    _userStreamController.add(userData);
  }

  bool isUserAuthorized() {
    return _localStorageService.sessionToken != null;
  }

  UserData? getCurrentUser() {
    try {
      return _localStorageService.userData;
    } catch (error) {
      Log.debug(error);
    }
    return null;
  }

  String getUserIdentifier() {
    String? userIdentifier = _localStorageService.userIdentifier;
    if (userIdentifier == null) {
      userIdentifier = generateUserIdentifier();
      _localStorageService.userIdentifier = userIdentifier;
    }
    return userIdentifier;
  }

  Future<UserData> getProfile() async {
    try {
      final responseData = await _apiClientService.getUserProfile();
      _updateUserData(responseData);
      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<void> updateProfile({required String fullName, String? dateOfBirth}) async {
    try {
      final effectiveDateOfBirth = dateOfBirth
          ?.parseLocalDateTime(AppConstants.localDateFormat)
          .toLocalString(AppConstants.dateOfBirthFormat);

      await _apiClientService.updateUserProfile(
        UpdateProfileRequest(fullName: fullName, dateOfBirth: effectiveDateOfBirth),
      );

      UserData? userData = _localStorageService.userData;
      if (userData != null) {
        _updateUserData(userData.copyWith(fullName: fullName, dateOfBirth: effectiveDateOfBirth));
      }
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<void> userUnauthorized() async {
    await Future.wait<void>([_firebaseService.deleteToken(), _localStorageService.clearData()]);
    _userStreamController.add(null);
  }
}
