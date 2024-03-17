import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, work, leisure, travel }

final Map categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff
};

class Expense {
  Expense(
      {required this.title,
      required this.amout,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final int amout;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
