import 'package:flutter/material.dart';

import '../../../../meta/color/colors_meta.dart';

class ListTileHeading extends StatelessWidget {
  final String title;
  const ListTileHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.kBlack.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
