import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Safe {
  @HiveField(0)
  final int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  int amount;
  @HiveField(3)
  String deadline;

  Safe({
    required this.id,
    required this.title,
    required this.amount,
    required this.deadline,
  });
}

class SafeAdapter extends TypeAdapter<Safe> {
  @override
  final typeId = 1;

  @override
  Safe read(BinaryReader reader) {
    return Safe(
      id: reader.read(),
      title: reader.read(),
      amount: reader.read(),
      deadline: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Safe obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.amount);
    writer.write(obj.deadline);
  }
}
