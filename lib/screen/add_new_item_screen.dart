import 'package:flutter/material.dart';
import 'package:learn_flutter/data/categories.dart';
import 'package:learn_flutter/models/category.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() {
    return _AddNewItemScreenState();
  }
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String itemName = '';
  int quantity = 1;
  Category category = categories[Categories.vegetables]!;

  void _addItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print(itemName);
      print(quantity);
      print(category);
    }
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
                  onSaved: (value) {
                    itemName = value!;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Kuantitas"),
                        ),
                        keyboardType: TextInputType.number,
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
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: category,
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
                        onChanged: (value) {
                          setState(() {
                            category = value!;
                          });
                        },
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
