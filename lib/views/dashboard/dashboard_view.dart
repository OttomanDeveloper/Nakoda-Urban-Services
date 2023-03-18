import 'package:customer/core/url/url_core.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/widgets/drawer/drawer_widgets_dashboard_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DashboardView extends StatefulWidget {
  final String? notificationUrl;
  const DashboardView({super.key, this.notificationUrl});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  /// `WebViewController` and `RefreshController` for `InAppWebView`
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

  /// Create a Instance of `ScaffoldState` `GlobalKey`
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    /// Initialize `PullToRefreshController`
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(color: Colors.white),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                  urlRequest: URLRequest(
                    url: await webViewController?.getUrl(),
                  ),
                );
              }
            },
          );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if controller is null then don't do anything
        // Check of webview can go back then good otherwise close the app
        if (await webViewController?.canGoBack() ?? false) {
          // Go Back to previous Page
          return await webViewController!.goBack().then((_) => false);
        }
        // Close the app
        return Future<bool>.value(true);
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
              // Check if Controller is not null and Url is not empty then proceed the request
              if (url.isNotEmpty && webViewController != null) {
                return await webViewController!.loadUrl(
                  urlRequest: URLRequest(url: WebUri(url)),
                );
              }
              return;
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: InAppWebView(
                initialSettings: InAppWebViewSettings(
                  underPageBackgroundColor: AppColors.kWhite,
                ),
                pullToRefreshController: pullToRefreshController,
                initialUrlRequest: URLRequest(url: WebUri(Constants.mainUrl)),
                shouldOverrideUrlLoading: (con, NavigationAction n) async {
                  // Get request url
                  final String url = n.request.url.toString();
                  // Check if Url is whatsapp then call url opener
                  if (url.contains("https://api.whatsapp.com/")) {
                    urlOpenner(context: context, url: url);
                    // prevent request to execute
                    return NavigationActionPolicy.CANCEL;
                  } else {
                    // Allow request to navigate
                    return NavigationActionPolicy.ALLOW;
                  }
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                  // Now WebView Controller is Created so tried to load notification url
                  // Make sure controller is not null
                  if (webViewController != null) {
                    // Now check if Url is not empty then load the url
                    if ((widget.notificationUrl ?? "").isNotEmpty) {
                      webViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri(widget.notificationUrl!),
                        ),
                      );
                    }
                  }
                  return;
                },
                onPermissionRequest: (_, PermissionRequest request) async {
                  return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
