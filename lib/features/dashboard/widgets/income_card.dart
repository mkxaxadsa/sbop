import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/income.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/dialogs/delete_dialog.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../../transaction/bloc/transaction_bloc.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({super.key, required this.income});

  final Income income;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SvgPicture.asset(
            getCategoryAsset(income.category),
            width: 55,
            height: 55,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextR(income.category, fontSize: 20),
                const SizedBox(height: 6),
                TextR(
                  income.date,
                  fontSize: 13,
                  color: AppColors.text1,
                ),
              ],
            ),
          ),
          TextR(
            income.isIncome ? '\$${income.amount}' : '-\$${income.amount}',
            fontSize: 20,
          ),
          const SizedBox(width: 10),
          CupertinoButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DeleteDialog(
                    title: 'Delete?',
                    onYes: () {
                      context
                          .read<TransactionBloc>()
                          .add(DeleteIncomeEvent(id: income.id));
                    },
                  );
                },
              );
            },
            padding: EdgeInsets.zero,
            minSize: 24,
            child: const Icon(
              Icons.close_rounded,
              color: AppColors.text1,
            ),
          ),
        ],
      ),
    );
  }
}
