import 'package:flutter/material.dart';

@immutable
abstract class Constants {
  const Constants._();

  /// Contains Website Main url for HomePage
  static const String mainUrl = "https://m.nakodadcs.com/";

  /// Sub Pages based on ${mainUrl}
  static const String aboutUsUrl = "$mainUrl/about-us.php";
  static const String cleaningServicesUrl =
      "$mainUrl/Service/Cleaning-Services";
  static const String pestControl = "$mainUrl/Service/pest-control-service";
  static const String acServicesUrl = "$mainUrl/Service/ac-services";
  static const String contactUs = "917669955211";
  static const String termsOfUse = "$mainUrl/Terms-conditions.php";
  static const String email = "support@nakodadcs.com";

  /// Contains App Name here
  static const String appName = "Nakoda Urban Services";

  /// Contains Onesignal App ID [For Push Notifications]
  static const String onesignalID = "4617cb94-49d5-4b64-9097-955a7ea75713";

  static const String facebook = "https://www.facebook.com/nakodaurbanservice";
  static const String whatsapp =
      "https://wa.me/919625196326?text=Hi%27,%20like%20to%20chat%20with%20you";
  static const String instagram = "https://www.instagram.com/";
  static const String linkdin =
      "https://www.linkedin.com/company/nakoda-urban-services";
}
