import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'db/db.dart';
import 'models/income.dart';

double navBarHeight = 85;

int getCurrentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

String formatTimestamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedDate = DateFormat('dd.MM.yyyy').format(date);
  return formattedDate;
}

String formatDateTime(DateTime date) {
  String formattedDate = DateFormat('dd.MM.yyyy').format(date);
  return formattedDate;
}

DateTime convertToDateTime(String date) {
  try {
    return DateFormat('dd.MM.yyyy').parse(date);
  } catch (e) {
    return DateTime.now();
  }
}

String getNowString() {
  DateTime date = DateTime.now();
  String formattedDate = DateFormat('dd.MM.yyyy').format(date);
  return formattedDate;
}

bool getButtonActive(List<TextEditingController> controllers) {
  for (TextEditingController controller in controllers) {
    if (controller.text.isEmpty) return false;
  }
  return true;
}

double getStatusBar(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

double getBottom(BuildContext context) {
  return MediaQuery.of(context).viewPadding.bottom;
}

void precacheImages(BuildContext context) {
  List<String> imageAssets = [
    'assets/profile.png',
    'assets/onboard1.png',
    'assets/onboard2.png',
    'assets/safe.png',
  ];
  for (String assets in imageAssets) {
    precacheImage(AssetImage(assets), context);
  }
}

String getCategoryAsset(String cat) {
  if (cat == 'Work') return 'assets/cat1.svg';
  if (cat == 'Cash') return 'assets/cat2.svg';
  if (cat == 'Shopping') return 'assets/cat3.svg';
  if (cat == 'Medicine') return 'assets/cat4.svg';
  if (cat == 'Sport') return 'assets/cat5.svg';
  if (cat == 'Travel') return 'assets/cat6.svg';
  return 'assets/cat1.svg';
}

int getAmount(bool isIncome) {
  int incomeAmount = 0;
  int expenseAmount = 0;
  for (Income income in incomesList) {
    if (income.isIncome) {
      incomeAmount += income.amount;
    } else {
      expenseAmount += income.amount;
    }
  }
  if (isIncome) return incomeAmount;
  return expenseAmount;
}

int getCategoryAmount(String cat) {
  int amount = 0;
  for (Income income in incomesList) {
    if (income.category == cat && !income.isIncome) amount += income.amount;
  }
  return amount;
}

int getMonthIncome(int month) {
  int amount = 0;
  for (Income income in incomesList) {
    if (income.isIncome) {
      DateTime date = convertToDateTime(income.date);
      if (date.month == month) amount += income.amount;
    }
  }
  return amount;
}

double normalizeIncomes(int month) {
  try {
    List<int> values = [
      getMonthIncome(1),
      getMonthIncome(2),
      getMonthIncome(3),
      getMonthIncome(4),
      getMonthIncome(5),
      getMonthIncome(6),
      getMonthIncome(7),
      getMonthIncome(8),
      getMonthIncome(9),
      getMonthIncome(10),
      getMonthIncome(11),
      getMonthIncome(12),
    ];
    int maxValue = values.reduce((a, b) => a > b ? a : b);
    for (int i = 0; i < values.length; i++) {
      values[i] = (values[i] * 20 / maxValue).round();
    }
    return values[month - 1] + 3.toDouble();
  } catch (e) {
    return 3;
  }
}
