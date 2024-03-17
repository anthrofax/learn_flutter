import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key});

  @override
  State<NewExpenses> createState() {
    return _NewExpansesState();
  }
}

class _NewExpansesState extends State<NewExpenses> {
  // String _enteredTitle = '';

  // void _onSaveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _onShowDatePicker() {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);

    showDatePicker(context: context, firstDate: firstDate, lastDate: now);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // onChanged: _onSaveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Expense Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: "\$ "),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Selected Date"),
                    IconButton(
                        onPressed: _onShowDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_amountController.text);
                  },
                  child: const Text("Save Expense"))
            ],
          )
        ],
      ),
    );
  }
}
