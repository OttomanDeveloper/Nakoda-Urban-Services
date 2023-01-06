import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashView(),
      title: Constants.appName,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.kBlue,
        scaffoldBackgroundColor: AppColors.kBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.kWhite,
          textColor: AppColors.kWhite,
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
    );
  }
}
