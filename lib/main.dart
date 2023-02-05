import 'dart:developer';

import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/dashboard_view.dart';
import 'package:customer/views/initial/initial_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // Check if the onesignal id is available then initialize the onesignal sdk
  if (Constants.onesignalID.isNotEmpty) {
    OneSignal.shared.setAppId(Constants.onesignalID);
    OneSignal.shared.setLaunchURLsInApp(true);
    OneSignal.shared.setNotificationOpenedHandler(_handleNotificationOpened);
  }
  return runApp(const InitialView());
}

// What to do when the user opens/taps on a notification
void _handleNotificationOpened(OSNotificationOpenedResult r) {
  // Print in debug console
  if (kDebugMode) {
    log(r.notification.jsonRepresentation());
  }
  // Get Notification LaunchUrl in Separat Url
  final String url = r.notification.launchUrl ?? "";
  // Check if notification launchUrl is not empty
  if (url.isNotEmpty) {
    // Navigate to Dashboard with Url
    globalNavKey.currentState?.pushReplacement(CupertinoPageRoute(
      builder: (_) => DashboardView(notificationUrl: url),
    ));
  }
}
