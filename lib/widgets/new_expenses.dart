import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';
import 'package:learn_flutter/widgets/input_judul_pengeluaran.dart';
import 'package:learn_flutter/widgets/input_nilai_pengeluaran.dart';
import 'package:learn_flutter/widgets/input_tanggal.dart';

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

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text("Data Invalid"),
                content: const Text(
                    "Data yang kamu inputkan masih ada yang tidak valid. Mohon periksa lagi data yang kamu inputkan"),
                actions: [
                  TextButton(
                      onPressed: () => {Navigator.pop(ctx)},
                      child: const Text("Ok"))
                ],
              ));
    } else {
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
    }
  }

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
      _showDialog();
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
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, contraints) {
      final width = contraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
          child: Column(
            children: [
              if (width > 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InputJudulPengeluaran(
                          titleController: _titleController),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    Expanded(
                      child: InputNilaiPengeluaran(
                        amountController: _amountController,
                      ),
                    ),
                  ],
                )
              else
                // TextField(
                //   // onChanged: _onSaveTitleInput,
                //   controller: _titleController,
                //   maxLength: 50,
                //   decoration:
                //       const InputDecoration(label: Text("Judul Pengeluaran")),
                // ),
                InputJudulPengeluaran(titleController: _titleController),
              if (width > 600)
                Row(
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
                    InputTanggal(
                        onShowDatePicker: _onShowDatePicker,
                        selectedDate: _selectedDate),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: InputNilaiPengeluaran(
                        amountController: _amountController,
                      ),
                    ),
                    InputTanggal(
                        onShowDatePicker: _onShowDatePicker,
                        selectedDate: _selectedDate)
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              if (width > 600)
                Row(
                  children: [
                    const Spacer(),
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
              else
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
        ),
      );
    });
  }
}
