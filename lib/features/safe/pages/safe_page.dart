import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/others/no_data.dart';
import '../bloc/safe_bloc.dart';
import '../widgets/safe_card.dart';

class SafePage extends StatelessWidget {
  const SafePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const CustomAppbar('Safe'),
            BlocBuilder<SafeBloc, SafeState>(
              builder: (context, state) {
                if (state is SafeLoadedState) {
                  if (state.safes.isEmpty) return const NoData();

                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      children: [
                        const SizedBox(height: 10),
                        ...List.generate(
                          state.safes.length,
                          (index) {
                            return SafeCard(safe: state.safes[index]);
                          },
                        ),
                        SizedBox(height: 160 + getBottom(context)),
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
        Positioned(
          bottom: 100 + getBottom(context),
          left: 0,
          right: 0,
          child: Center(
            child: PrimaryButton(
              title: 'Add +',
              width: 190,
              white: true,
              onPressed: () {
                context.push('/safe-add');
              },
            ),
          ),
        ),
      ],
    );
  }
}
