import 'dart:convert';

import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import 'package:learn_flutter/data/categories.dart';
import 'package:learn_flutter/models/grocery.dart';
import 'package:learn_flutter/screen/add_new_item_screen.dart';
import 'package:learn_flutter/widget/grocery_item.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<Grocery> groceriesList = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        "flutter-prep-fe77f-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping-list.json");

    final response = await http.get(url);
    Map<String, dynamic> result = json.decode(response.body);
    List<Grocery> tempGroceryList = [];

    for (final item in result.entries) {
      final category = categories.entries.firstWhere(
          (catData) => catData.value.categoryName == item.value['category']);

      tempGroceryList.add(Grocery(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category.value));
    }

    setState(() {
      groceriesList = tempGroceryList;
    });
  }

  void _addItem() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddNewItemScreen()));

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text("No Groceries"));

    if (groceriesList.isNotEmpty) {
      content = ListView.builder(
          itemCount: groceriesList.length,
          itemBuilder: (ctx, i) => Dismissible(
                key: ValueKey(groceriesList[i]),
                onDismissed: (direction) {
                  setState(() {
                    groceriesList.remove(groceriesList[i]);
                  });
                },
                child: GroceryItem(
                  key: ValueKey(groceriesList[i].id),
                  name: groceriesList[i].name,
                  quantity: groceriesList[i].quantity,
                  color: groceriesList[i].category.color,
                ),
              ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Groceries',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            )
          ],
          centerTitle: false,
        ),
        body: content);
  }
}
