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