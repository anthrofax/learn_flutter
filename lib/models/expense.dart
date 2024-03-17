import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  Expense({required this.title, required this.amout, required this.date}) : id = uuid.v4();

  final String id;
  final String title;
  final int amout;
  final DateTime date;
}
