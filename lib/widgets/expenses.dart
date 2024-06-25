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

  void onDeleteExpense(Expense expense) {
    final int deletedExpenseIndex = _registeredExpense.indexOf(expense);

    setState(() {
      _registeredExpense.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Daftar pengeluaranmu berhasil dihapus"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () => {
                setState(() {
                  _registeredExpense.insert(deletedExpenseIndex, expense);
                })
              }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child:
          Text("Catatan pengeluaranmu belum ada, silahkan tambahkan beberapa."),
    );

    if (_registeredExpense.isNotEmpty) {
      setState(() {
        mainContent = ExpenseList(
            expenses: _registeredExpense, onDeleteExpense: onDeleteExpense);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Expense Tracker"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: _openExpenseOverlay, icon: const Icon(Icons.add)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [const Text("Chart"), Expanded(child: mainContent)],
          ),
        ));
  }
}
