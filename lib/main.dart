import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vagan': false,
    'vegetarian': false,
  };

  List<int> deleteId = [];
  void _setDeleteId(int _removeId) {
    setState(() {
      deleteId.add(_removeId);
      print("deleted ${deleteId.toString()}");
    });
    deletedItem();
  }

  List<Meal> _avaliableMeal = [];
  @override
  void initState() {
    _setFilters(_filters);
    super.initState();
  }

  void _setFilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;

      _avaliableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vagan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
      deletedItem();
    });
  }

  void deletedItem() {
    for (int i = 0; i < deleteId.length; i++) {
      _avaliableMeal.removeWhere((meal) => meal.id == deleteId[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.lightGreen[900],
        canvasColor: Colors.lightGreen[200],
        appBarTheme: AppBarTheme(
          centerTitle: true,
          textTheme: TextTheme(
            headline5: TextStyle(fontSize: 15),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 20, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(40, 80, 40, 1),
              ),
              headline6: TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
      ),
      routes: {
        '/': (context) => TabsScreen(),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_avaliableMeal, _setDeleteId),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_setDeleteId),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
