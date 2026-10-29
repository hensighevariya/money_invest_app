import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:money_invest_app/src/core/core.dart';
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
      if (responseData.address != null && responseData.address!.isNotEmpty) {
        _localStorageService.address = responseData.address;
      }
      return responseData;
    } catch (error, stackTrace) {
      throw transformError(error, stackTrace);
    }
  }

  String? getAddress() => _localStorageService.address;

  void saveAddress(String address) {
    _localStorageService.address = address;
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? address,
    String? pincode,
    String? countryId,
    String? stateId,
    String? cityId,
  }) async {
    try {
      final currentUser = getCurrentUser();

      String resolvedFirstName = firstName ?? currentUser?.firstName ?? '';
      String resolvedLastName = lastName ?? currentUser?.lastName ?? '';

      if (resolvedFirstName.isEmpty && fullName != null && fullName.isNotEmpty) {
        final parts = fullName.trim().split(RegExp(r'\s+'));
        resolvedFirstName = parts.isNotEmpty ? parts.first : '';
        resolvedLastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      } else if (resolvedFirstName.isEmpty && (currentUser?.fullName.isNotEmpty ?? false)) {
        final parts = currentUser!.fullName.trim().split(RegExp(r'\s+'));
        resolvedFirstName = parts.isNotEmpty ? parts.first : '';
        resolvedLastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      }

      final resolvedAddress = address ?? currentUser?.address ?? _localStorageService.address;
      final resolvedPincode = pincode ?? currentUser?.pincode;
      final resolvedCountryId = countryId ?? currentUser?.countryId;
      final resolvedStateId = stateId ?? currentUser?.stateId;
      final resolvedCityId = cityId ?? currentUser?.cityId;

      await _apiClientService.updateUserProfile(
        UpdateProfileRequest(
          firstName: resolvedFirstName.isNotEmpty ? resolvedFirstName : 'User',
          lastName: resolvedLastName,
          countryId: resolvedCountryId,
          stateId: resolvedStateId,
          cityId: resolvedCityId,
          address: resolvedAddress,
          pincode: resolvedPincode,
        ),
      );

      final combinedFullName = fullName ?? '$resolvedFirstName $resolvedLastName'.trim();

      if (currentUser != null) {
        final updated = currentUser.copyWith(
          firstName: resolvedFirstName,
          lastName: resolvedLastName,
          fullName: combinedFullName.isNotEmpty ? combinedFullName : currentUser.fullName,
          phoneNumber: phoneNumber ?? currentUser.phoneNumber,
          email: email ?? currentUser.email,
          address: resolvedAddress,
          pincode: resolvedPincode,
          countryId: resolvedCountryId,
          stateId: resolvedStateId,
          cityId: resolvedCityId,
        );
        _updateUserData(updated);
      }
      if (resolvedAddress != null) {
        _localStorageService.address = resolvedAddress;
      }
      return true;
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

  Future<bool> deleteAccount({String deleteReason = 'No longer needed'}) async {
    try {
      await _apiClientService.deleteAccount(deleteReason: deleteReason);
    } catch (error, stackTrace) {
      final transformed = transformError(error, stackTrace);
      if (transformed is SessionExpiredException ||
          transformed is InvalidSessionException ||
          transformed is AccountInactiveError) {
        await userUnauthorized();
        return true;
      }
      throw transformed;
    }
    await userUnauthorized();
    return true;
  }

  Future<void> userUnauthorized() async {
    try {
      await _firebaseService.deleteToken();
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace);
    }
    try {
      await _localStorageService.clearData();
    } catch (error, stackTrace) {
      Log.error(error);
      Log.error(stackTrace);
    }
    _userStreamController.add(null);
  }
}
