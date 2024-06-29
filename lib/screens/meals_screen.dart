
import 'package:flutter/material.dart';
import 'package:flutter_internals/models/meals.dart';


class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.dummyMeals, required this.title});

  final String title;
  final List<Meal> dummyMeals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(itemBuilder: (ctx, i) {
      return 
    }),
    );
  }
}