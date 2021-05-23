import 'package:flutter/material.dart';
import '../widgets/min_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  String get title {
    switch (_selectedTabIndex) {
      case 0:
        return 'Category';

      case 1:
        return 'Favorite';
      default:
        return 'Category';
    }
  }

  Widget get pageTab {
    switch (_selectedTabIndex) {
      case 0:
        return CategoriesScreen();

      case 1:
        return FavoritesScreen();
      default:
        return CategoriesScreen();
    }
  }

  int _selectedTabIndex = 0;

  _selectedTap(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: MinDrawer(),
      body: pageTab,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTap,
        currentIndex: _selectedTabIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        unselectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
