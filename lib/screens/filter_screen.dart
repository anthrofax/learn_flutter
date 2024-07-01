import 'package:flutter/material.dart';
// import 'package:flutter_internals/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFreeFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter mu'),
      ),
      // drawer: MainDrawer(selectScreen: (identifier) {
      //   Navigator.of(context).pop();

      //   if (identifier == 'makanan') {
      //     Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (ctx) => const FilterScreen()));
      //   }
      // }),
      body: Column(
        children: [
          SwitchListTile(
            value: glutenFreeFilterSet,
            onChanged: (isChecked) {
              if (isChecked) {
                setState(() {
                  glutenFreeFilterSet = isChecked;
                });
              }
            },
            title: Text(
              "Bebas gula",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              "Hanya makanan yang mengandung gula",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          )
        ],
      ),
    );
  }
}
