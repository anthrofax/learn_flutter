import 'package:flutter/material.dart';
import 'package:flutter_internals/provider/filter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

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
            value: activeFilters[FilterOptions.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .watch(filtersProvider.notifier)
                  .setFilter(FilterOptions.glutenFree, isChecked);
            },
            title: Text(
              "Bebas gula",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              "Hanya makanan yang tidak mengandung gula",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[FilterOptions.lactosaFree]!,
            onChanged: (isChecked) {
              ref
                  .watch(filtersProvider.notifier)
                  .setFilter(FilterOptions.lactosaFree, isChecked);
            },
            title: Text(
              "Bebas laktosa",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              "Hanya makanan yang tidak mengandung laktosa",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[FilterOptions.vegan]!,
            onChanged: (isChecked) {
              ref
                  .watch(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegan, isChecked);
            },
            title: Text(
              "Makanan vegetarian",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              "Hanya makanan untuk vegetarian",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[FilterOptions.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .watch(filtersProvider.notifier)
                  .setFilter(FilterOptions.vegetarian, isChecked);
            },
            title: Text(
              "Makanan vegan",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            subtitle: Text(
              "Hanya makanan vegan",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
