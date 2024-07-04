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
            child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
              validator: (value) {
                return 'Demo....';
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
                TextButton(onPressed: () {}, child: const Text("Reset")),
                ElevatedButton(onPressed: () {}, child: const Text("Add Item"))
              ],
            )
          ],
        )),
      ),
    );
  }
}
