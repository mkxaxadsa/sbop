import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/texts/text_r.dart';

class CategoryExpenseData extends StatelessWidget {
  const CategoryExpenseData({
    super.key,
    required this.category,
    required this.amount,
  });

  final String category;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: getCategoryColor(category),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            SvgPicture.asset(getCategoryAsset(category)),
            TextR(category, fontSize: 20),
            const SizedBox(height: 16),
            TextB('\$$amount', fontSize: 24),
          ],
        ),
      ),
    );
  }
}
