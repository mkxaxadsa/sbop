import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/income.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/textfields/txt_field.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../../home/bloc/home_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/category_button.dart';
import '../widgets/transaction_type_button.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final controller1 = TextEditingController(); // amount
  final controller2 = TextEditingController(); // date
  final controller3 = TextEditingController(); // category

  bool active = false;
  bool income = true;

  void changeIncome(bool value) {
    if (value == income) return;
    setState(() {
      income = value;
    });
  }

  void checkActive() {
    if (controller2.text.length == 10) {
      setState(() {
        active = getButtonActive([
          controller1,
          controller2,
          controller3,
        ]);
      });
    }
  }

  void onCategory(String value) {
    setState(() {
      controller3.text = value;
    });
    checkActive();
  }

  void onAdd() {
    context.read<TransactionBloc>().add(
          AddIncomeEvent(
            income: Income(
              id: getCurrentTimestamp(),
              isIncome: income,
              amount: int.tryParse(controller1.text) ?? 0,
              date: controller2.text,
              category: controller3.text,
            ),
          ),
        );
    context.read<HomeBloc>().add(ChangePageEvent(index: 0));
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
    return Column(
      children: [
        const CustomAppbar('Add transaction'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            children: [
              const SizedBox(height: 10),
              TransactionTypeButton(
                title: 'Income',
                white: !income,
                value: true,
                onPressed: changeIncome,
              ),
              const SizedBox(height: 24),
              TransactionTypeButton(
                title: 'Expense',
                white: income,
                value: false,
                onPressed: changeIncome,
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  SizedBox(width: 15),
                  TextM('Enter the amount', fontSize: 20),
                ],
              ),
              const SizedBox(height: 20),
              TxtField(
                controller: controller1,
                hintText: '\$0',
                number: true,
                length: 6,
                onChanged: checkActive,
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  SizedBox(width: 15),
                  TextM('Enter the date', fontSize: 20),
                ],
              ),
              const SizedBox(height: 20),
              TxtField(
                controller: controller2,
                hintText: '00.00.0000',
                number: true,
                date: true,
                onChanged: checkActive,
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  SizedBox(width: 15),
                  TextM('Choose a category', fontSize: 20),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                runSpacing: 30,
                children: [
                  if (income) ...[
                    CategoryButton(
                      id: 1,
                      title: 'Work',
                      active: controller3.text == 'Work',
                      onPressed: onCategory,
                    ),
                    CategoryButton(
                      id: 2,
                      title: 'Cash',
                      active: controller3.text == 'Cash',
                      onPressed: onCategory,
                    ),
                  ] else ...[
                    CategoryButton(
                      id: 3,
                      title: 'Shopping',
                      active: controller3.text == 'Shopping',
                      onPressed: onCategory,
                    ),
                    CategoryButton(
                      id: 4,
                      title: 'Medicine',
                      active: controller3.text == 'Medicine',
                      onPressed: onCategory,
                    ),
                    CategoryButton(
                      id: 5,
                      title: 'Sport',
                      active: controller3.text == 'Sport',
                      onPressed: onCategory,
                    ),
                    CategoryButton(
                      id: 6,
                      title: 'Travel',
                      active: controller3.text == 'Travel',
                      onPressed: onCategory,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: PrimaryButton(
                  title: 'Add +',
                  width: 190,
                  active: active,
                  white: !active,
                  onPressed: onAdd,
                ),
              ),
              SizedBox(height: 16 + navBarHeight + getBottom(context)),
            ],
          ),
        ),
      ],
    );
  }
}
