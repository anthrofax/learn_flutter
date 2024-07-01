import 'package:flutter/material.dart';
import 'package:flutter_internals/screens/categories_screen.dart';
import 'package:flutter_internals/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void selectTab(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    String activePageTitle = "Kategori";

    if (_selectedPageIndex == 1) {
      activePageTitle = "Daftar Makanan Favorit";
      activePage = const MealsScreen(meals: []);
    }

    return (Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
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
