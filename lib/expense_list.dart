import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => Text(expenses[index].title));
  }
}
