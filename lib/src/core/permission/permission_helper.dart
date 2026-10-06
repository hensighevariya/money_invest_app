import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:permission_handler/permission_handler.dart';

import 'permission_status.dart';

enum PermissionHelper {
  notification(Permission.notification),
  camera(Permission.camera),
  location(Permission.location),
  photos(Permission.photos),
  storage(Permission.storage);

  final permission_handler.Permission permission;

  const PermissionHelper(this.permission);

  PermissionResult _getPermissionResult(PermissionStatus status) {
    return switch (status) {
      PermissionStatus.denied => PermissionResult.denied,
      PermissionStatus.granted ||
      PermissionStatus.provisional ||
      PermissionStatus.limited => PermissionResult.granted,
      PermissionStatus.restricted ||
      PermissionStatus.permanentlyDenied => PermissionResult.permanentlyDenied,
    };
  }

  ServiceResult _getServiceResult(ServiceStatus status) {
    return switch (status) {
      ServiceStatus.disabled => ServiceResult.disabled,
      ServiceStatus.enabled => ServiceResult.enabled,
      ServiceStatus.notApplicable => ServiceResult.notApplicable,
    };
  }

  Future<PermissionResult> requestPermission() async {
    if (permission == Permission.unknown) return PermissionResult.granted;
    final status = await permission.request();
    return _getPermissionResult(status);
  }

  Future<PermissionResult> checkPermission() async {
    if (permission == Permission.unknown) return PermissionResult.granted;
    final status = await permission.status;
    return _getPermissionResult(status);
  }

  Future<ServiceResult> checkService() async {
    if (permission is PermissionWithService) {
      final status = await (permission as PermissionWithService).serviceStatus;
      return _getServiceResult(status);
    }
    return ServiceResult.notApplicable;
  }

  static Future<bool> openAppSettings() => permission_handler.openAppSettings();
}
