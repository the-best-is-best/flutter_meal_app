import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;

  const FavoritesScreen(this.favoriteMeal);
  
  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text('You have no  favorites yes - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: favoriteMeal[index].id,
          imageUrl: favoriteMeal[index].imageUrl,
          title: favoriteMeal[index].title,
          duration: favoriteMeal[index].duration,
          complexity: favoriteMeal[index].complexity,
          affordability: favoriteMeal[index].affordability,
          removeItem: () {},
        ),
        itemCount: favoriteMeal.length,
      );
    }
  }
}
