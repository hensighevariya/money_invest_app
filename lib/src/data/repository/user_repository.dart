import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_invest_app/src/core/base/repository.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/log.dart';
import 'package:money_invest_app/src/data/services/network/request/user.dart';

final class UserRepository extends BaseRepository {
  UserRepository({
    required this._localStorageService,
    required this._apiClientService,
    required this._firebaseService,
  });

  final LocalStorageService _localStorageService;
  final ApiClientService _apiClientService;
  final FirebaseService _firebaseService;

  final StreamController<UserData?> _userStreamController =
      StreamController.broadcast();

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

  void setUserData(UserData userData) {
    _localStorageService.userData = userData;
  }

  bool isUserAuthorized() {
    return _localStorageService.isLoggedIn &&
        (_localStorageService.sessionToken?.isNotEmpty ?? false);
  }

  UserData? getCurrentUser() {
    try {
      return _localStorageService.userData;
    } catch (error) {
      Log.debug(error);
    }
    return null;
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

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _apiClientService.changeUserPassword(
        ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );
      return true;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<bool> updateNotificationStatus({
    required bool isNotification,
    String? pushToken,
  }) async {
    try {
      String? token = pushToken;
      if (token == null || token.isEmpty) {
        try {
          if (Firebase.apps.isNotEmpty) {
            token = await _firebaseService.getToken();
          }
        } catch (_) {}
      }
      final effectiveToken = (token != null && token.isNotEmpty)
          ? token
          : 'fcm_token_sample_1234567890abcdef';

      await _apiClientService.updateNotificationStatus(
        isNotification: isNotification,
        pushToken: effectiveToken,
      );

      final currentUser = getCurrentUser();
      if (currentUser != null) {
        _updateUserData(currentUser.copyWith(isNotification: isNotification));
      }
      return true;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  Future<void> userUnauthorized() async {
    await Future.wait<void>([
      _firebaseService.deleteToken(),
      _localStorageService.clearData(),
    ]);
    _userStreamController.add(null);
  }
}
