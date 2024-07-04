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
  final List<Grocery> groceriesList = [];

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
              onPressed: () async {
                var result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AddNewItemScreen()));

                if (result == null) {
                  return;
                }

                setState(() {
                  groceriesList.add(result);
                });
              },
              icon: const Icon(Icons.add),
            )
          ],
          centerTitle: false,
        ),
        body: ListView.builder(
            itemCount: groceriesList.length,
            itemBuilder: (ctx, i) => GroceryItem(
                  key: ValueKey(groceriesList[i].id),
                  name: groceriesList[i].name,
                  quantity: groceriesList[i].quantity,
                  color: groceriesList[i].category.color,
                )));
  }
}
