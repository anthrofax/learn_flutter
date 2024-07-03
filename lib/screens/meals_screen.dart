import 'package:flutter/material.dart';
import 'package:flutter_internals/models/meal.dart';
import 'package:flutter_internals/screens/meal_detail_screen.dart';
import 'package:flutter_internals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.meals,
      this.title});

  final String? title;
  final List<Meal> meals;

  void navigateToDetailMealItem(BuildContext context, Meal meal) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealDetailScreen(
                  meal: meal,
                )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Opps, belum ada makanan dengan kategori ini',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Silahkan pilih kategori lain',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            meal: meals[i],
            navigateToDetailMealItem: () {
              navigateToDetailMealItem(context, meals[i]);
            },
          );
        },
        itemCount: meals.length,
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
