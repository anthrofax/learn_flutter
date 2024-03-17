import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/expense_list/expenses_list.dart';
import 'package:learn_flutter/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'Flutter Course',
        amout: 109000,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amout: 25000,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Chart"),
          ExpenseList(expenses: _registeredExpense)
        ],
      ),
    );
  }
}
