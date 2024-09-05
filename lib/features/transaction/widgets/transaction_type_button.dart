import 'package:flutter/cupertino.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/texts/text_r.dart';

class TransactionTypeButton extends StatelessWidget {
  const TransactionTypeButton({
    super.key,
    required this.title,
    required this.white,
    required this.value,
    required this.onPressed,
  });

  final String title;
  final bool white;
  final bool value;
  final void Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: white ? AppColors.white : AppColors.main,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CupertinoButton(
        onPressed: () {
          onPressed(value);
        },
        padding: EdgeInsets.zero,
        child: Center(
          child: TextM(
            title,
            fontSize: 20,
            color: white ? AppColors.main : AppColors.white,
          ),
        ),
      ),
    );
  }
}
