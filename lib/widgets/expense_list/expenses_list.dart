import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';
import 'package:learn_flutter/widgets/expense_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onDeleteExpense});

  final List<Expense> expenses;

  final void Function(Expense expense) onDeleteExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) => Dismissible(
                key: ValueKey(expenses[index]),
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.50),
                  margin: EdgeInsets.symmetric(
                      horizontal:
                          Theme.of(context).cardTheme.margin!.horizontal),
                ),
                onDismissed: (direction) => onDeleteExpense(expenses[index]),
                child: ExpenseItem(expenses[index]),
              )),
    );
  }
}
