import 'package:customer/meta/color/colors_meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final String? svgAsset, pngAsset;
  const DrawerTile({
    super.key,
    this.icon,
    this.svgAsset,
    this.pngAsset,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () => onTap(),
      iconColor: AppColors.kBlack.withOpacity(0.72),
      textColor: AppColors.kBlack.withOpacity(0.72),
      visualDensity: const VisualDensity(vertical: -1.95),
      leading: icon != null
          ? Icon(icon, size: iconSize)
          : svgAsset != null
              ? SvgPicture.string(
                  svgAsset!,
                  width: iconSize,
                  height: iconSize,
                  color: AppColors.kBlack.withOpacity(0.72),
                )
              : pngAsset != null
                  ? Image.asset(pngAsset!, width: iconSize, height: iconSize)
                  : null,
    );
  }

  /// Hold Icon Size
  double get iconSize => 24.00;
}
