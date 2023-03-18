import 'dart:async';
import 'dart:developer';
import 'package:customer/firebase_options.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/dashboard_view.dart';
import 'package:customer/views/initial/initial_view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
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
    // Initialize InAppWebView Debug content
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    // Initialize Firebase Core
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Get a instance of Firebase Analytics
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    return runApp(InitialView(analytics: analytics));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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
