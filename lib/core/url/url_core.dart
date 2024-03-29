import 'package:customer/core/snackbar/snackbar_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void urlOpenner({
  required String? url,
  required BuildContext context,
}) async {
  // Make Sure url is not null
  if (url != null && url.isNotEmpty) {
    try {
      if (!await launchUrl(
        Uri.tryParse(url)!,
        mode: LaunchMode.externalApplication,
      )) {
        return showSnackbar(
          context: context,
          icon: Icons.clear_outlined,
          msg: 'Could not launch url',
        );
      }
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
      return showSnackbar(
        context: context,
        icon: Icons.clear_outlined,
        msg: "Oops! Can't open this url",
      );
    }
  } else {
    return showSnackbar(context: context, msg: "Enter Valid Url");
  }
}
