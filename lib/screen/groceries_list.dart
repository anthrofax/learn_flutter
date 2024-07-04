import 'package:flutter/material.dart';
import 'package:learn_flutter/models/grocery.dart';
import 'package:learn_flutter/screen/add_new_item_screen.dart';
import 'package:learn_flutter/widget/grocery_item.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key, required this.groceriesList});

  final List<Grocery> groceriesList;

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AddNewItemScreen()));
              },
              icon: const Icon(Icons.add),
            )
          ],
          centerTitle: false,
        ),
        body: ListView.builder(
            itemCount: widget.groceriesList.length,
            itemBuilder: (ctx, i) => GroceryItem(
                  key: ValueKey(widget.groceriesList[i].id),
                  name: widget.groceriesList[i].name,
                  quantity: widget.groceriesList[i].quantity,
                  color: widget.groceriesList[i].category.color,
                )));
  }
}
