import 'package:flutter/material.dart';
import 'package:flutter_internals/models/meal.dart';
import 'package:flutter_internals/provider/favorite_provider.dart';
import 'package:flutter_internals/provider/filter_provider.dart';
import 'package:flutter_internals/provider/meal_provider.dart';
import 'package:flutter_internals/screens/categories_screen.dart';
import 'package:flutter_internals/screens/filter_screen.dart';
import 'package:flutter_internals/screens/meals_screen.dart';
import 'package:flutter_internals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  // ConsumerWidget klo stateless widget
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void selectTab(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filter') {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
      Navigator.push<Map<FilterOptions, bool>>(
          context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = "Kategori";

    if (_selectedPageIndex == 1) {
      activePageTitle = "Daftar Makanan Favorit";
      activePage = MealsScreen(
        meals: ref.watch(favoriteMealsProvider),
      );
    }

    return (Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        selectScreen: _selectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Kategori"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorit"),
        ],
        currentIndex: _selectedPageIndex,
      ),
    ));
  }
}
