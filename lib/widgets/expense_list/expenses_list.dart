import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';
import 'package:learn_flutter/widgets/expense_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) => ExpenseItem(expenses[index])),
    );
  }
}
