import 'package:flutter/material.dart';
import 'package:flutter_internals/models/meal.dart';
import 'package:flutter_internals/screens/categories_screen.dart';
import 'package:flutter_internals/screens/filter_screen.dart';
import 'package:flutter_internals/screens/meals_screen.dart';
import 'package:flutter_internals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
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

  void _selectScreen(String identifier) {
    Navigator.of(context).pop();

    if (identifier == 'filter') {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteStatus,
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
