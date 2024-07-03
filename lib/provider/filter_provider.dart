import 'package:flutter_internals/provider/meal_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterOptions {
  glutenFree,
  lactosaFree,
  vegetarian,
  vegan,
}

class FilterNotifer extends StateNotifier<Map<FilterOptions, bool>> {
  FilterNotifer():super({
    FilterOptions.glutenFree: false,
    FilterOptions.lactosaFree : false,
    FilterOptions.vegan :false,
    FilterOptions.vegetarian : false,
  });

  void setFilters(Map<FilterOptions, bool> chosenFilters) {
   state = chosenFilters;
  }

  void setFilter(FilterOptions filter, bool isActive) {
    state = {
      ...state,
      filter: isActive
    };
  }
}

final filtersProvider = StateNotifierProvider<FilterNotifer, Map<FilterOptions, bool>>((ref) {
  return FilterNotifer();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
      if (selectedFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (selectedFilters[FilterOptions.lactosaFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (selectedFilters[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }

      if (selectedFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();
});