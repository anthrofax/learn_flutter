import 'package:flutter/material.dart';
import 'package:flutter_internals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Image.network(
        meal.imageUrl,
        fit: BoxFit.cover,
        height: 300,
        width: double.infinity,
      ),
    ));
  }
}
