import 'dart:async';
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

  Future<void> userUnauthorized() async {
    await Future.wait<void>([
      _firebaseService.deleteToken(),
      _localStorageService.clearData(),
    ]);
    _userStreamController.add(null);
  }
}
