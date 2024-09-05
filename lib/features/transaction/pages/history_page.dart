import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../dashboard/widgets/income_card.dart';
import '../bloc/transaction_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar('History'),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is IncomeLoadedState) {
                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    children: [
                      const SizedBox(height: 10),
                      ...List.generate(
                        state.incomes.length,
                        (index) {
                          return IncomeCard(income: state.incomes[index]);
                        },
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(
                        title: 'Back',
                        white: true,
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
