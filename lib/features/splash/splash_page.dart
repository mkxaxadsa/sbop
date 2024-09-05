import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_colors.dart';
import '../../core/db/prefs.dart';
import '../../core/widgets/others/loading_widget.dart';
import '../safe/bloc/safe_bloc.dart';
import '../transaction/bloc/transaction_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void load() async {
    context.read<TransactionBloc>().add(GetIncomesEvent());
    context.read<SafeBloc>().add(GetSafesEvent());

    await getData().then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        if (onboard) {
          context.go('/onboard');
        } else {
          context.go('/home');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bg,
      body: LoadingWidget(),
    );
  }
}
