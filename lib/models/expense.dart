import 'package:uuid/uuid.dart';

const uuid = Uuid();
enum Category {food, work, leisure, travel}

class Expense {
  Expense({required this.title, required this.amout, required this.date, required this.category}) : id = uuid.v4();

  final String id;
  final String title;
  final int amout;
  final DateTime date;
  final Category category;
}
