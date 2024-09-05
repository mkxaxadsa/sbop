import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/others/no_data.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../../transaction/bloc/transaction_bloc.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/income_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbar('Dashboard'),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is IncomeLoadedState) {
              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  children: [
                    const SizedBox(height: 10),
                    DashboardCard(
                      income: state.incomeAmount,
                      expense: state.expenseAmount,
                    ),
                    const SizedBox(height: 13),
                    const Row(
                      children: [
                        SizedBox(width: 15),
                        TextM('History', fontSize: 32),
                      ],
                    ),
                    const SizedBox(height: 13),
                    if (state.incomes.isEmpty)
                      const NoData()
                    else
                      ...List.generate(
                        state.incomes.length,
                        (index) {
                          return IncomeCard(income: state.incomes[index]);
                        },
                      ),
                    SizedBox(height: navBarHeight + getBottom(context)),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
