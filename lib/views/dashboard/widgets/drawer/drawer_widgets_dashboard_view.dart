import 'package:customer/meta/assets/assets_meta.dart';
import 'package:customer/meta/color/colors_meta.dart';
import 'package:customer/meta/constants/constants_meta.dart';
import 'package:customer/views/dashboard/widgets/drawer/drawer_tile_widget.dart';
import 'package:customer/views/dashboard/widgets/drawertileheading/drawertileheading_widgets_dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;
  final void Function(String url) loadUrlRequest;
  final void Function(String url) externalUrlRequest;
  const DashboardDrawer({
    super.key,
    required this.globalKey,
    required this.loadUrlRequest,
    required this.externalUrlRequest,
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
              SizedBox(height: size.height * 0.007),
              DrawerTile(
                isSvg: true,
                title: "Login",
                svgAsset: Assets.register,
                onTap: () => loadUrlRequest(Constants.loginLink),
              ),
              DrawerTile(
                title: "About Us",
                icon: Icons.info_outline,
                onTap: () => loadUrlRequest(Constants.aboutUsUrl),
              ),
              DrawerTile(
                title: "Cleaning Services",
                icon: Icons.wash_outlined,
                onTap: () => loadUrlRequest(Constants.cleaningServicesUrl),
              ),
              DrawerTile(
                title: "AC Services",
                icon: Icons.settings_outlined,
                onTap: () => loadUrlRequest(Constants.acServicesUrl),
              ),
              DrawerTile(
                title: "Pest Control",
                icon: Icons.settings_accessibility_outlined,
                onTap: () => loadUrlRequest(Constants.pestControl),
              ),
              DrawerTile(
                isSvg: true,
                title: "Our Blog",
                svgAsset: Assets.blog,
                onTap: () => loadUrlRequest(Constants.blogLink),
              ),
              SizedBox(height: size.height * 0.015),
              const ListTileHeading(title: 'Info Pages:'),
              SizedBox(height: size.height * 0.007),
              DrawerTile(
                title: "Contact Us",
                icon: Icons.phone_outlined,
                onTap: () => externalUrlRequest(
                  Uri(scheme: 'tel', path: Constants.contactUs).toString(),
                ),
              ),
              DrawerTile(
                title: "Email",
                icon: CupertinoIcons.envelope,
                onTap: () => externalUrlRequest(
                  Uri(scheme: 'mailto', path: Constants.email).toString(),
                ),
              ),
              DrawerTile(
                title: "Terms of Use",
                icon: Icons.note_alt_outlined,
                onTap: () => loadUrlRequest(Constants.termsOfUse),
              ),
              DrawerTile(
                isSvg: true,
                title: "Privacy Policy",
                svgAsset: Assets.privacyPolicy,
                onTap: () => loadUrlRequest(Constants.privacyPolicy),
              ),
              SizedBox(height: size.height * 0.015),
              const ListTileHeading(title: 'Social Media:'),
              SizedBox(height: size.height * 0.007),
              DrawerTile(
                title: "Facebook",
                icon: Icons.facebook_outlined,
                onTap: () => externalUrlRequest(Constants.facebook),
              ),
              DrawerTile(
                title: "Instagram",
                icon: FontAwesomeIcons.instagram,
                onTap: () => externalUrlRequest(Constants.instagram),
              ),
              DrawerTile(
                title: "LinkedIn",
                icon: FontAwesomeIcons.linkedinIn,
                onTap: () => externalUrlRequest(Constants.linkdin),
              ),
              DrawerTile(
                isSvg: true,
                title: "WhatsApp",
                svgAsset: Assets.whatsApp,
                onTap: () => externalUrlRequest(Constants.whatsapp),
              ),
              DrawerTile(
                isSvg: true,
                title: "Twitter",
                svgAsset: Assets.twitter,
                onTap: () => externalUrlRequest(Constants.twitter),
              ),
              DrawerTile(
                isSvg: true,
                title: "Partner Login",
                svgAsset: Assets.login,
                onTap: () => loadUrlRequest(Constants.vendorLogin),
              ),
              SizedBox(height: size.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
