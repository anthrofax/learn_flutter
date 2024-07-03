import 'package:flutter/material.dart';
import 'package:flutter_internals/data/dummy_data.dart';
import 'package:flutter_internals/models/meal.dart';
import 'package:flutter_internals/provider/meal_provider.dart';
import 'package:flutter_internals/screens/categories_screen.dart';
import 'package:flutter_internals/screens/filter_screen.dart';
import 'package:flutter_internals/screens/meals_screen.dart';
import 'package:flutter_internals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<FilterOptions, bool> kInitFilterState = {
  FilterOptions.glutenFree: false,
  FilterOptions.lactosaFree: false,
  FilterOptions.vegan: false,
  FilterOptions.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget { // ConsumerWidget klo stateless widget
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<FilterOptions, bool> _selectedFilters = kInitFilterState;
  final List<Meal> _favoriteMeals = [];

  void selectTab(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleFavoriteStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
        showMarkedFavoriteMessage(
            "Item ini telah dihapus dari daftar favorit anda.");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        showMarkedFavoriteMessage(
            "Item ini berhasil ditambahkan ke daftar favorit anda.");
      });
    }
  }

  void showMarkedFavoriteMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 4),
    ));
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filter') {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
      var filterResult = await Navigator.push<Map<FilterOptions, bool>>(
          context,
          MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                    currentFilterStatus: _selectedFilters,
                  )));

      setState(() {
        _selectedFilters = filterResult ?? kInitFilterState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    final List<Meal> availableMeals = meals.where((meal) {
      if (_selectedFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (_selectedFilters[FilterOptions.lactosaFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (_selectedFilters[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }

      if (_selectedFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteStatus,
      availableMeals: availableMeals,
    );
    String activePageTitle = "Kategori";

    if (_selectedPageIndex == 1) {
      activePageTitle = "Daftar Makanan Favorit";
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavoriteStatus,
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
