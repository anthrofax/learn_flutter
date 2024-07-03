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

  void setFilters(FilterOptions chosenFilters, bool isActive) {
    state = {
      ...state,
      chosenFilters
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifer, Map<FilterOptions, bool>>((ref) {
  return FilterNotifer();
})