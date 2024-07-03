import 'package:flutter_internals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifer() : super([]);

  void toggleFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifer, List<Meal>>((ref) {
  return FavoriteMealsNotifer();
});
