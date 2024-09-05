import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_scaffold.dart';
import '../../transaction/pages/add_transaction_page.dart';
import '../../dashboard/pages/dashboard_page.dart';
import '../../safe/pages/safe_page.dart';
import '../../transaction/pages/transactions_page.dart';
import '../bloc/home_bloc.dart';
import '../widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeAdd) return const AddTransactionPage();

              if (state is HomeTransactions) return const TransactionsPage();

              if (state is HomeSafe) return const SafePage();

              return const DashboardPage();
            },
          ),
          const NavBar(),
        ],
      ),
    );
  }
}
