import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/splash/splash_view.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// GlobalKey for Navigation
final GlobalKey<NavigatorState> globalNavKey = GlobalKey<NavigatorState>();

class InitialView extends StatelessWidget {
  final FirebaseAnalytics analytics;
  const InitialView({super.key, required this.analytics});

  /// Create a instance of FacebookAppEvents
  static final FacebookAppEvents fbEvent = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashView(),
      title: Constants.appName,
      themeMode: ThemeMode.light,
      navigatorKey: globalNavKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.kBlue,
        scaffoldBackgroundColor: AppColors.kBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.kBlack,
          textColor: AppColors.kBlack,
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 18,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.kWhite,
          iconTheme: IconThemeData(color: AppColors.kBlack),
          actionsIconTheme: IconThemeData(color: AppColors.kBlack),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.kWhite,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.kWhite,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}
