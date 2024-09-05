import 'package:hive_flutter/hive_flutter.dart';

import '../models/income.dart';
import '../models/safe.dart';

String boxName = 'mybox20';
List<Income> incomesList = [];
List<Safe> safesList = [];

Future<void> initHive() async {
  await Hive.initFlutter();
  // await Hive.deleteBoxFromDisk(boxName);
  Hive.registerAdapter(IncomeAdapter());
  Hive.registerAdapter(SafeAdapter());
}

Future<void> getIncomes() async {
  final box = await Hive.openBox(boxName);
  List data = box.get('incomesList') ?? [];
  incomesList = data.cast<Income>();
}

Future<void> updateIncomes() async {
  final box = await Hive.openBox(boxName);
  box.put('incomesList', incomesList);
  incomesList = await box.get('incomesList');
}

Future<void> getSafes() async {
  final box = await Hive.openBox(boxName);
  List data = box.get('safesList') ?? [];
  safesList = data.cast<Safe>();
}

Future<void> updateSafes() async {
  final box = await Hive.openBox(boxName);
  box.put('safesList', safesList);
  safesList = await box.get('safesList');
}
