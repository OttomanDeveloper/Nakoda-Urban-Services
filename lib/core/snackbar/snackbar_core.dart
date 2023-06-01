import 'package:flutter/material.dart';

import '../../meta/color/colors_meta.dart';

void showSnackbar({
  required String msg,
  required BuildContext context,
  IconData icon = Icons.info_outline,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        Icon(icon, color: AppColors.kWhite),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            msg,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16, color: AppColors.kWhite),
          ),
        ),
      ],
    ),
  ));
}
