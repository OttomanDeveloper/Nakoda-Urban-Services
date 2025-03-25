import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class PermissionManager {
  /// Requests notification permission from the user (particularly important for Android 13+)
  Future<void> askNotificationPermission() async {
    // Make initial permission request
    final PermissionStatus result = await _request(Permission.notification);
    // Workaround for Android 13: Sometimes the first request doesn't properly trigger
    // the system prompt, so we make a second request if the first was granted
    if (result == PermissionStatus.granted) {
      await _request(Permission.notification);
    }
    return;
  }

  /// Internal helper method to handle the actual permission request
  Future<PermissionStatus> _request(Permission permission) {
    return permission.request();
  }
}
