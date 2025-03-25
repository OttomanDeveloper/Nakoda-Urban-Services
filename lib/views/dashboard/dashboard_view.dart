import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:customer/core/url/url_core.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:customer/views/dashboard/widgets/drawer/drawer_widgets_dashboard_view.dart';

class DashboardView extends StatefulWidget {
  final String? notificationUrl;
  const DashboardView({super.key, this.notificationUrl});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  /// Create a Instance of `WebViewControllerPlus`
  late WebViewControllerPlus _webViewController;

  /// Create a Instance of `ScaffoldState` `GlobalKey`
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    /// Initialize WebViewControllerPlus
    _webViewController = WebViewControllerPlus()
      ..setBackgroundColor(AppColors.kWhite)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          /// Check if Url is whatsapp then call url opener
          if (request.url.contains("https://api.whatsapp.com/")) {
            urlOpenner(context: context, url: request.url);
            // prevent request to execute
            return NavigationDecision.prevent;
          } else {
            // Allow request to navigate
            return NavigationDecision.navigate;
          }
        },
      ))
      ..loadRequest(Uri.parse(widget.notificationUrl ?? Constants.mainUrl));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdate();
    });
    super.initState();
  }

  /// This method:
  /// 1. Checks for updates using the platform-specific in-app update API
  /// 2. If an update is available, starts a flexible update (background download)
  /// 3. Handles and logs any errors that occur during the process
  Future<void> checkForUpdate() async {
    try {
      return InAppUpdate.checkForUpdate().then<void>((AppUpdateInfo info) {
        // Verify that an update is actually available (not just unknown or not available)
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          // Start a flexible update (downloads in background, installs on next restart)
          InAppUpdate.startFlexibleUpdate();
        }
        return;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        log("checkForUpdate: Error: ${e.toString()}");
      }
    } catch (e) {
      if (kDebugMode) {
        log("checkForUpdate: Error: ${e.toString()}");
      }
    } finally {
      if (kDebugMode) {
        log("checkForUpdate: Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) async {
        // If the pop already occurred (unlikely in our case since canPop is false),
        // just return without additional action
        if (didPop) {
          return;
        }
        // First try to navigate back in the WebView's history if possible
        if (await _webViewController.canGoBack()) {
          // Navigate to the previous page in WebView's history stack
          return await _webViewController.goBack();
        }
        // If WebView has no back history, close the entire application
        exit(0);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.kWhite,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.kWhite,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _key,
          backgroundColor: AppColors.kWhite,
          drawer: DashboardDrawer(
            globalKey: _key,
            loadUrlRequest: (String url) async {
              // Close the SideBar by opening the end drawer
              _key.currentState?.openEndDrawer();
              // Check if the provided URL is not empty before processing
              if (url.isNotEmpty) {
                // Load the parsed URL in the WebView controller
                return _webViewController.loadRequest(Uri.parse(url));
              }
            },
            externalUrlRequest: (String url) {
              // Close the SideBar by opening the end drawer
              _key.currentState?.openEndDrawer();
              // Check if the provided URL is not empty before processing
              if (url.isNotEmpty) {
                // Open the URL in an external browser using the urlOpenner utility
                return urlOpenner(context: context, url: url);
              }
            },
          ),
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 40,
            titleSpacing: 6.0,
            title: Row(
              children: [
                Image.asset(
                  "assets/appbar_logo.png",
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
            leading: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  child: const Icon(Icons.menu),
                  onTap: () {
                    if ((_key.currentState?.isDrawerOpen ?? false)) {
                      return _key.currentState?.openEndDrawer();
                    } else {
                      return _key.currentState?.openDrawer();
                    }
                  },
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: WebViewWidget(controller: _webViewController),
            ),
          ),
        ),
      ),
    );
  }
}
