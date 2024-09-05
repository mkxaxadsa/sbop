import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../utils.dart';
import '../texts/text_r.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: EdgeInsets.only(top: getStatusBar(context)),
      child: CupertinoButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        child: const Row(
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.white,
            ),
            SizedBox(width: 5),
            TextM(
              'Back',
              fontSize: 16,
              color: AppColors.white,
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
