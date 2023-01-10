import 'package:flutter/material.dart';

import '../../../meta/color/colors_meta.dart';

void snackbar({
  required String msg,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.kBlue,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    duration: const Duration(milliseconds: 1650),
    content: Text(
      msg,
      textAlign: TextAlign.start,
      style: const TextStyle(fontSize: 17, color: AppColors.kWhite),
    ),
  ));
}
