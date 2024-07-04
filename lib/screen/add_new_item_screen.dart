import 'package:flutter/material.dart';
import 'package:learn_flutter/data/categories.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() {
    return _AddNewItemScreenState();
  }
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  void _addItem() {
    _formKey.currentState!.validate();
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Nama harus terdiri dari 2 - 50 karakter';
                    }

                    return null; // Return null jika validasi berhasil
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Kuantitas"),
                        ),
                        initialValue: '1',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! < 0) {
                            return "Kuantitas harus berupa angka positif";
                          }

                          return null; // Return null jika validasi berhasil
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(category.value.categoryName)
                                ],
                              ),
                            )
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _resetForm, child: const Text("Reset")),
                    ElevatedButton(
                        onPressed: _addItem, child: const Text("Add Item"))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
