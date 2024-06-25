import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/expense_list/expenses_list.dart';
import 'package:learn_flutter/models/expense.dart';
import 'package:learn_flutter/widgets/new_expenses.dart';

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

  void _openExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(onAddExpense));
  }

  void onAddExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: _openExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text("Chart"),
          const SizedBox(
            height: 12,
          ),
          ExpenseList(expenses: _registeredExpense)
        ],
      ),
    );
  }
}
