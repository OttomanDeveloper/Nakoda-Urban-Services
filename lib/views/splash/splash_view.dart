import 'package:customer/core/permissions/permissions_core.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/views/dashboard/dashboard_view.dart';
import 'package:customer/views/widgets/video_player/splash_video_player_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ask for Notification Permission
      return PermissionManager().askNotificationPermission();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.kWhite,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.kWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        body: SplashVideoPlayer(
          onEnd: () {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => const DashboardView()),
              (_) => false,
            );
          },
        ),
      ),
    );
  }
}
