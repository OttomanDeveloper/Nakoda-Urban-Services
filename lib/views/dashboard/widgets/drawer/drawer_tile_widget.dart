import 'package:customer/meta/color/colors_meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerTile extends StatelessWidget {
  final bool isSvg;
  final String title;
  final IconData icon;
  final String? svgAsset;
  final VoidCallback onTap;
  const DrawerTile({
    super.key,
    this.svgAsset,
    this.isSvg = false,
    required this.onTap,
    required this.title,
    this.icon = Icons.info_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () => onTap(),
      iconColor: AppColors.kBlack.withOpacity(0.72),
      textColor: AppColors.kBlack.withOpacity(0.72),
      visualDensity: const VisualDensity(vertical: -1.95),
      leading: isSvg
          ? SvgPicture.string(
              svgAsset ?? "",
              color: AppColors.kBlack.withOpacity(0.72),
            )
          : Icon(icon),
    );
  }
}
