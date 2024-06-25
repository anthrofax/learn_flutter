import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

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
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _onShowDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _onSubmitForm() {
    final int? enteredAmount = int.tryParse(_amountController.text);
    bool isAmountValid = enteredAmount != null;

    if (_titleController.text.trim().isEmpty ||
        !isAmountValid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Data Invalid"),
                content: const Text(
                    "Data yang kamu inputkan masih ada yang tidak valid. Mohon periksa lagi data yang kamu inputkan"),
                actions: [
                  TextButton(
                      onPressed: () => {Navigator.pop(ctx)},
                      child: const Text("Ok"))
                ],
              ));

      return;
    }

    // Save leisure data
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amout: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    // Close Modal
    Navigator.pop(context);
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
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            // onChanged: _onSaveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Judul Pengeluaran")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                      label: Text("Nilai"),
                      prefixText: "\Rp. ",
                      suffixText: ', 00-'),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate != null
                        ? formatter.format(_selectedDate!)
                        : "Tanggal"),
                    const SizedBox(
                      width: 20,
                    ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (category) => {
                        setState(() {
                          if (category == null) {
                            return;
                          }
                          _selectedCategory = category;
                        })
                      }),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Batalkan")),
                  ElevatedButton(
                      onPressed: _onSubmitForm,
                      child: const Text("Simpan Pengeluaran"))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
