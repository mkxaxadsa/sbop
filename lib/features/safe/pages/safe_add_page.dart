import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/safe.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../bloc/safe_bloc.dart';

class SafeAddPage extends StatefulWidget {
  const SafeAddPage({super.key});

  @override
  State<SafeAddPage> createState() => _SafeAddPageState();
}

class _SafeAddPageState extends State<SafeAddPage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  bool active = false;

  void checkActive() {
    setState(() {
      active = getButtonActive([
        controller1,
        controller2,
        controller3,
      ]);
    });
  }

  void onSave() {
    context.read<SafeBloc>().add(
          AddSafeEvent(
            safe: Safe(
              id: getCurrentTimestamp(),
              title: controller1.text,
              amount: int.tryParse(controller2.text) ?? 0,
              deadline: controller3.text,
            ),
          ),
        );
    context.pop();
  }

  void onBack() {
    context.pop();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar('Safe'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              children: [
                const SizedBox(height: 16),
                const Row(
                  children: [
                    SizedBox(width: 15),
                    TextM('Title', fontSize: 20),
                  ],
                ),
                const SizedBox(height: 20),
                TxtField(
                  controller: controller1,
                  hintText: 'Title',
                  onChanged: checkActive,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    SizedBox(width: 15),
                    TextM('Amount', fontSize: 20),
                  ],
                ),
                const SizedBox(height: 20),
                TxtField(
                  controller: controller2,
                  hintText: 'Amount (\$)',
                  number: true,
                  length: 6,
                  onChanged: checkActive,
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    SizedBox(width: 15),
                    TextM('Deadline', fontSize: 20),
                  ],
                ),
                const SizedBox(height: 20),
                TxtField(
                  controller: controller3,
                  hintText: '00.00.0000',
                  date: true,
                  onChanged: checkActive,
                ),
                Image.asset(
                  'assets/safe.png',
                  width: 248,
                  height: 248,
                ),
                Center(
                  child: PrimaryButton(
                    title: 'Save',
                    active: active,
                    white: !active,
                    width: 190,
                    onPressed: onSave,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: PrimaryButton(
                    title: 'Back',
                    white: true,
                    width: 190,
                    onPressed: onBack,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
