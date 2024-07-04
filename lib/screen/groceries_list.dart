import 'package:flutter/material.dart';
import 'package:learn_flutter/models/grocery.dart';
import 'package:learn_flutter/widget/grocery_item.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key, required this.groceriesList});

  final List<Grocery> groceriesList;

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
