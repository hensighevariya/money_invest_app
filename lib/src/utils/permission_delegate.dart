import 'dart:io';

import 'package:common_extensions/common_extensions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/localization/localization.dart';
import 'package:money_invest_app/src/presentation/components/components.dart';
import 'package:money_invest_app/src/presentation/resources/resources.dart';

abstract base class PermissionDelegate {
  PermissionDelegate(this.context);

  final BuildContext context;

  Future<bool> get hasPermission;

  Future<bool> _resolvePermission(PermissionHelper permissionHelper) async {
    PermissionResult permissionResult = await permissionHelper
        .checkPermission();
    switch (permissionResult) {
      case PermissionResult.denied:
        break;
      case PermissionResult.granted:
        return true;
      case PermissionResult.permanentlyDenied:
        return false;
    }

    permissionResult = await permissionHelper.requestPermission();
    return permissionResult == PermissionResult.granted;
  }

  void showPermissionDeniedAlert();

  Future<void> _shouldShowPermissionDeniedAlert(
    PermissionHelper permissionHelper,
    String permissionName,
  ) async {
    PermissionResult permissionResult = await permissionHelper
        .checkPermission();
    switch (permissionResult) {
      case PermissionResult.granted:
        break;
      case PermissionResult.denied:
        _showPermissionDeniedAlert(permissionName);
      case PermissionResult.permanentlyDenied:
        _showPermissionPermanentlyDeniedAlert(permissionName);
    }
  }

  void _showPermissionDeniedAlert(String permissionName) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final localizations = context.localizations;

        return PermissionAlertDialog(
          title: localizations.permissionDeniedModalTitle,
          description: localizations.permissionDeniedDescription(
            permissionName,
          ),
          action: ElevatedButton(
            style: ElevatedButtonPrimaryStyle(context),
            onPressed: () {
              context.navigator.pop();
              PermissionHelper.openAppSettings();
            },
            child: Text(localizations.openSettingsButtonLabel),
          ),
        );
      },
    );
  }

  void _showPermissionPermanentlyDeniedAlert(String permissionName) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final localizations = context.localizations;

        return PermissionAlertDialog(
          title: localizations.permissionDeniedModalTitle,
          description: localizations.permissionPermanentlyDeniedDescription(
            permissionName,
          ),
          action: ElevatedButton(
            style: ElevatedButtonPrimaryStyle(context),
            onPressed: () {
              context.navigator.pop();
              PermissionHelper.openAppSettings();
            },
            child: Text(localizations.openSettingsButtonLabel),
          ),
        );
      },
    );
  }
}

final class CameraPermissionDelegate extends PermissionDelegate {
  CameraPermissionDelegate(super.context);

  @override
  Future<bool> get hasPermission async {
    return _resolvePermission(PermissionHelper.camera);
  }

  @override
  void showPermissionDeniedAlert() {
    _shouldShowPermissionDeniedAlert(
      PermissionHelper.camera,
      AppLocalizations.current.cameraPermissionLabel,
    );
  }
}

final class StoragePermissionDelegate extends PermissionDelegate {
  StoragePermissionDelegate(super.context);

  Future<bool> _isPermissionRequired() async {
    if (Platform.isIOS) return false;

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) return false;
    }

    return true;
  }

  @override
  Future<bool> get hasPermission async {
    bool isPermissionRequired = await _isPermissionRequired();
    if (!isPermissionRequired) return true;

    return _resolvePermission(PermissionHelper.storage);
  }

  @override
  Future<void> showPermissionDeniedAlert() async {
    bool isPermissionRequired = await _isPermissionRequired();
    if (!isPermissionRequired) return;

    _shouldShowPermissionDeniedAlert(
      PermissionHelper.storage,
      AppLocalizations.current.storagePermissionLabel,
    );
  }
}

final class PhotosPermissionDelegate extends PermissionDelegate {
  PhotosPermissionDelegate(super.context);

  Future<bool> _isPermissionRequired() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) return false;
    }

    return true;
  }

  @override
  Future<bool> get hasPermission async {
    bool isPermissionRequired = await _isPermissionRequired();
    if (!isPermissionRequired) return true;

    PermissionHelper permissionHelper = PermissionHelper.photos;
    if (Platform.isAndroid) {
      permissionHelper = PermissionHelper.storage;
    }

    return _resolvePermission(permissionHelper);
  }

  @override
  Future<void> showPermissionDeniedAlert() async {
    bool isPermissionRequired = await _isPermissionRequired();
    if (!isPermissionRequired) return;

    PermissionHelper permissionHelper = PermissionHelper.photos;
    String permissionName = AppLocalizations.current.photosPermissionLabel;
    if (Platform.isAndroid) {
      permissionHelper = PermissionHelper.storage;
      permissionName = AppLocalizations.current.storagePermissionLabel;
    }

    await _shouldShowPermissionDeniedAlert(permissionHelper, permissionName);
  }
}

final class NotificationPermissionDelegate extends PermissionDelegate {
  NotificationPermissionDelegate(super.context);

  @override
  Future<bool> get hasPermission async {
    return _resolvePermission(PermissionHelper.notification);
  }

  @override
  void showPermissionDeniedAlert() {
    _shouldShowPermissionDeniedAlert(
      PermissionHelper.notification,
      AppLocalizations.current.notificationPermissionLabel,
    );
  }
}
