import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(expense.title),
          Row(
            children: [
              Text("\$${expense.amout.toStringAsFixed(2)}"),
              const Spacer(),
               Row(
                children: [
                  const Icon(Icons.alarm),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expense.date.toString()),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
