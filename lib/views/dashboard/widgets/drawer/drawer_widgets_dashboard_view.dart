import 'package:customer/core/url/url_core.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/widgets/drawertileheading/drawertileheading_widgets_dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final void Function(String) loadUrlRequest;
  const DashboardDrawer({
    super.key,
    required this.globalKey,
    required this.loadUrlRequest,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width * 0.7,
        color: AppColors.kWhite,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset("assets/logo.png", height: 150),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                Constants.appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.kBlack),
              ),
              SizedBox(height: size.height * 0.04),
              const ListTileHeading(title: 'Pages:'),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  return loadUrlRequest(Constants.aboutUsUrl);
                },
                leading: const Icon(Icons.info_outline),
                title: const Text("About Us"),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  return loadUrlRequest(Constants.cleaningServicesUrl);
                },
                leading: const Icon(Icons.wash_outlined),
                title: const Text("Cleaning Services"),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  return loadUrlRequest(Constants.acServicesUrl);
                },
                leading: const Icon(Icons.settings_outlined),
                title: const Text("AC Services"),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  return loadUrlRequest(Constants.pestControl);
                },
                leading: const Icon(Icons.settings_accessibility_outlined),
                title: const Text("Pest Control"),
              ),
              SizedBox(height: size.height * 0.015),
              const ListTileHeading(title: 'Info Pages:'),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Uri(
                      scheme: 'tel',
                      path: Constants.contactUs,
                    ).toString(),
                  );
                },
                title: const Text("Contact Us"),
                leading: const Icon(Icons.phone_outlined),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Uri(
                      scheme: 'mailto',
                      path: Constants.email,
                    ).toString(),
                  );
                },
                title: const Text("Email"),
                leading: const Icon(CupertinoIcons.envelope),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Constants.termsOfUse,
                  );
                },
                title: const Text("Terms of Use"),
                leading: const Icon(Icons.note_alt_outlined),
              ),
              SizedBox(height: size.height * 0.015),
              const ListTileHeading(title: 'Social Media:'),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Constants.facebook,
                  );
                },
                leading: const Icon(Icons.facebook_outlined),
                title: const Text("Facebook"),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Constants.instagram,
                  );
                },
                leading: const Icon(FontAwesomeIcons.instagram),
                title: const Text("Instagram"),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Constants.linkdin,
                  );
                },
                leading: const Icon(FontAwesomeIcons.linkedinIn),
                title: const Text("LinkedIn"),
              ),
              ListTile(
                onTap: () {
                  globalKey.currentState?.openEndDrawer();
                  urlOpenner(
                    context: context,
                    url: Constants.whatsapp,
                  );
                },
                leading: const Icon(Icons.whatshot_outlined),
                title: const Text("WhatsApp"),
              ),
              SizedBox(height: size.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
