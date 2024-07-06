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
  late Future<List<Grocery>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<Grocery>> _loadItems() async {
    final url = Uri.https(
        "flutter-prep-fe77f-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping-list.json");

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      // setState(() {
      //   _error = "Failed to load items. Please try again later.";
      // });
      throw Exception("Failed to load items. Please try again later.");
    }

    if (response.body == "null") {
      return [];
    }

    Map<String, dynamic> result = json.decode(response.body);
    List<Grocery> loadedItems = [];

    for (final item in result.entries) {
      final category = categories.entries.firstWhere(
          (catData) => catData.value.categoryName == item.value['category']);

      loadedItems.add(Grocery(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category.value));
    }

    return loadedItems;
  }

  void _addItem() async {
    Grocery? newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddNewItemScreen()));

    if (newItem == null) {
      return;
    }

    setState(() {
      groceriesList.add(newItem);
    });
  }

  void _deleteItem(Grocery item) async {
    final index = groceriesList.indexOf(item);

    setState(() {
      groceriesList.remove(item);
    });

    final url = Uri.https(
        "flutter-prep-fe77f-default-rtdb.asia-southeast1.firebasedatabase.app",
        "shopping-list/${item.id}.json");

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        groceriesList.insert(index, item);
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to delete item. Please try again later.")));
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
            future: _loadedItems,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(
                    child:
                        Text("Failed to load items. Please try again later."));
              }

              if (snapshot.data == null) {
                return const Center(child: Text("No Groceries"));
              }

              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, i) => Dismissible(
                        key: ValueKey(snapshot.data![i].id),
                        onDismissed: (direction) {
                          _deleteItem(snapshot.data![i]);
                        },
                        child: GroceryItem(
                          key: ValueKey(snapshot.data![i].id),
                          name: snapshot.data![i].name,
                          quantity: snapshot.data![i].quantity,
                          color: snapshot.data![i].category.color,
                        ),
                      ));
            }));
  }
}
