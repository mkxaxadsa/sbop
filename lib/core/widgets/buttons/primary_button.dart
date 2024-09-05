import 'package:flutter/cupertino.dart';

import '../../config/app_colors.dart';
import '../texts/text_r.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.active = true,
    this.white = false,
    this.width,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final bool white;
  final double? width;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: width,
      decoration: BoxDecoration(
        color: !white ? AppColors.main : AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CupertinoButton(
        onPressed: active ? onPressed : null,
        padding: EdgeInsets.zero,
        child: Center(
          child: TextM(
            title,
            fontSize: 20,
            color: !white ? AppColors.white : AppColors.main,
          ),
        ),
      ),
    );
  }
}
