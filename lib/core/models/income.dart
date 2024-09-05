import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Income {
  @HiveField(0)
  final int id;
  @HiveField(1)
  bool isIncome;
  @HiveField(2)
  int amount;
  @HiveField(3)
  String date;
  @HiveField(4)
  String category;

  Income({
    required this.id,
    required this.isIncome,
    required this.amount,
    required this.date,
    required this.category,
  });
}

class IncomeAdapter extends TypeAdapter<Income> {
  @override
  final typeId = 0;

  @override
  Income read(BinaryReader reader) {
    return Income(
      id: reader.read(),
      isIncome: reader.read(),
      amount: reader.read(),
      date: reader.read(),
      category: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Income obj) {
    writer.write(obj.id);
    writer.write(obj.isIncome);
    writer.write(obj.amount);
    writer.write(obj.date);
    writer.write(obj.category);
  }
}
