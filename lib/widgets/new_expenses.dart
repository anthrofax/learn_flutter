import 'package:flutter/material.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key});

  @override
  State<NewExpenses> createState() {
    return _NewExpansesState();
  }
}

class _NewExpansesState extends State<NewExpenses> {
  String _enteredTitle = '';

  void _onSaveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            onChanged: _onSaveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Expense Title")),
          ),
          ElevatedButton(onPressed: () {
             print(_enteredTitle);
          }, child: const Text("Save Expense"))
        ],
      ),
    );
  }
}
