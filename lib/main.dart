import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/initial/initial_view.dart';
import 'package:flutter/material.dart';
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
  }
  return runApp(const InitialView());
}
