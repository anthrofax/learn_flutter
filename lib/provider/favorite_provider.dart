import 'package:flutter_internals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifer() : super([]);

  bool toggleFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];

      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifer, List<Meal>>((ref) {
  return FavoriteMealsNotifer();
});
