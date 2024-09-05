import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/texts/text_r.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.id,
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final int id;
  final String title;
  final bool active;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: active
          ? null
          : () {
              onPressed(title);
            },
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: active ? AppColors.white : Colors.transparent,
                width: 3,
              ),
            ),
            child: SvgPicture.asset(
              'assets/cat$id.svg',
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(height: 10),
          TextR(title, fontSize: 20),
        ],
      ),
    );
  }
}
