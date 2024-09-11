import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:project20/main.dart';

import '../../core/config/app_colors.dart';
import '../../core/db/prefs.dart';
import '../../core/widgets/buttons/primary_button.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../../core/widgets/texts/text_r.dart';

class Finance extends StatefulWidget {
  final String fnjufsd;
  final String njdaksdas;
  final String mkda;

  Finance({
    required this.fnjufsd,
    required this.njdaksdas,
    required this.mkda,
  });

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  @override
  void initState() {
    super.initState();
    initializeAppTrackingTransparency();
  }

  @override
  Widget build(BuildContext context) {
    final String ajx =
        '${widget.fnjufsd}&external_Id=${widget.njdaksdas}${widget.mkda}';
    print(ajx);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(ajx),
          ),
        ),
      ),
    );
  }
}

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  String title = 'Keep your spending under control and manage your finances';
  String desc = 'Cost control and financial management';

  int pageIndex = 1;

  void onNext() async {
    if (pageIndex == 1) {
      setState(() {
        pageIndex++;
        title =
            'Track all categories of expenses and manage your finances effectively';
        desc = 'Record expenses in categories, keep records';
      });
    } else {
      await saveData().then((_) {
        context.go('/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Spacer(),
            TextM(
              title,
              fontSize: 32,
              color: AppColors.text1,
            ),
            const SizedBox(height: 40),
            TextR(
              desc,
              fontSize: 24,
              color: AppColors.white40,
            ),
            Image.asset('assets/onboard$pageIndex.png'),
            const Spacer(),
            PrimaryButton(
              title: 'Next',
              width: 190,
              onPressed: onNext,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
