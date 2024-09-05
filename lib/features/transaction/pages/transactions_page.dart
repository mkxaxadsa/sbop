import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../dashboard/widgets/dashboard_card.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/category_expense_data.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppbar('Transactions'),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is IncomeLoadedState) {
              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CategoryExpenseData(
                          category: 'Sport',
                          amount: getCategoryAmount('Sport'),
                        ),
                        const SizedBox(width: 18),
                        CategoryExpenseData(
                          category: 'Shopping',
                          amount: getCategoryAmount('Shopping'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        CategoryExpenseData(
                          category: 'Travel',
                          amount: getCategoryAmount('Travel'),
                        ),
                        const SizedBox(width: 18),
                        CategoryExpenseData(
                          category: 'Medicine',
                          amount: getCategoryAmount('Medicine'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    DashboardCard(
                      income: state.incomeAmount,
                      expense: state.expenseAmount,
                    ),
                    const SizedBox(height: 25),
                    PrimaryButton(
                      title: 'History',
                      white: true,
                      onPressed: () {
                        context.push('/history');
                      },
                    ),
                    SizedBox(height: 25 + navBarHeight + getBottom(context)),
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
