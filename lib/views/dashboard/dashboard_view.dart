import 'package:customer/core/url/url_core.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/widgets/drawer/drawer_widgets_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late WebViewController _webViewController;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Initialize WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.kWhite)
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
      ..loadRequest(Uri.parse(Constants.mainUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check of webview can go back then good otherwise close the app
        if (await _webViewController.canGoBack()) {
          // Go Back to previous Page
          return await _webViewController.goBack().then((_) => false);
        }
        // Close the app
        return true;
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
            webViewController: _webViewController,
          ),
          appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 40,
            titleSpacing: 6.0,
            title: Row(
              children: [
                Image.asset(
                  "assets/appbar_logo.png",
                  width: MediaQuery.of(context).size.width * 0.5,
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
              child: WebViewWidget(controller: _webViewController),
            ),
          ),
        ),
      ),
    );
  }
}
