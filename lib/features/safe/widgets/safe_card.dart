import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/safe.dart';
import '../../../core/widgets/dialogs/delete_dialog.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../bloc/safe_bloc.dart';

class SafeCard extends StatelessWidget {
  const SafeCard({super.key, required this.safe});

  final Safe safe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 42),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextR(safe.title, fontSize: 16),
          ),
          TextM(
            '\$${safe.amount}',
            fontSize: 16,
            color: AppColors.text1,
          ),
          const SizedBox(width: 24),
          const TextR('12.09.2024', fontSize: 16),
          const SizedBox(width: 24),
          CupertinoButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DeleteDialog(
                    title: 'Delete Safe?',
                    onYes: () {
                      context
                          .read<SafeBloc>()
                          .add(DeleteSafeEvent(id: safe.id));
                    },
                  );
                },
              );
            },
            padding: EdgeInsets.zero,
            minSize: 24,
            child: const Icon(
              Icons.close_rounded,
              color: AppColors.text2,
            ),
          ),
        ],
      ),
    );
  }
}
