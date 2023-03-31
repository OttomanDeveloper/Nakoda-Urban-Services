import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class PermissionManager {
  /// Ask for Notification Permission Android 13
  void askNotificationPermission() async {
    final PermissionStatus result = await _request(Permission.notification);
    // Check if Permission is Denied then again for for permission
    if (result == PermissionStatus.granted) {
      await _request(Permission.notification);
    }
    return;
  }

  /// Request For Permission
  Future<PermissionStatus> _request(Permission permission) {
    return permission.request();
  }
}
