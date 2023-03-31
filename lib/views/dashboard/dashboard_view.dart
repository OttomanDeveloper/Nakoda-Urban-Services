import 'package:customer/core/url/url_core.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/widgets/drawer/drawer_widgets_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class DashboardView extends StatefulWidget {
  final String? notificationUrl;
  const DashboardView({super.key, this.notificationUrl});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  WebViewPlusController? _webViewController;

  /// Create a Instance of `ScaffoldState` `GlobalKey`
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if controller is null then don't do anything
        // Check of webview can go back then good otherwise close the app
        if (await _webViewController?.webViewController.canGoBack() ?? false) {
          // Go Back to previous Page
          return await _webViewController!.webViewController
              .goBack()
              .then((_) => false);
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
              // Close SideBar
              _key.currentState?.openEndDrawer();
              // Check if Controller is not null and Url is not empty then proceed the request
              if (url.isNotEmpty && _webViewController != null) {
                return _webViewController!.loadUrl(url);
              }
              return;
            },
            externalUrlRequest: (String url) {
              // Close SideBar
              _key.currentState?.openEndDrawer();
              // Check if Url is not empty then open url in external browser
              if (url.isNotEmpty) {
                return urlOpenner(context: context, url: url);
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
              child: WebViewPlus(
                initialUrl: Constants.mainUrl,
                allowsInlineMediaPlayback: true,
                onPageFinished: (String url) {},
                backgroundColor: AppColors.kWhite,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewPlusController con) {
                  _webViewController = con;
                  // Now WebView Controller is Created so tried to load notification url
                  // Make sure controller is not null
                  if (_webViewController != null) {
                    // Now check if Url is not empty then load the url
                    if ((widget.notificationUrl ?? "").isNotEmpty) {
                      _webViewController!.loadUrl(widget.notificationUrl!);
                    }
                  }
                  return;
                },
                navigationDelegate: (NavigationRequest request) {
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
