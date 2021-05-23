import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = "/meal_detail";
  final Function saveDeleteId;
  final Function taggleFavorite;
  final Function isMealFavorite;

  const MealDetailScreen(
      this.saveDeleteId, this.taggleFavorite, this.isMealFavorite);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 30,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as int;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final String complexityText;
    final String affordabilityText;
    switch (selectMeal.complexity) {
      case Complexity.Simple:
        complexityText = 'Simple';
        break;
      case Complexity.Challenging:
        complexityText = 'Challenging';
        break;
      case Complexity.Hard:
        complexityText = 'Hard';
        break;
    }

    switch (selectMeal.affordability) {
      case Affordability.Affordable:
        affordabilityText = 'Affordable';
        break;
      case Affordability.Pricey:
        affordabilityText = 'Pricey';
        break;
      case Affordability.Luxurious:
        affordabilityText = 'Luxurious';
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectMeal.title,
          style: Theme.of(context).appBarTheme.textTheme!.headline5,
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.taggleFavorite(mealId);
              widget.isMealFavorite(mealId)
                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Add To Favorite"),
                    ))
                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Removed From Favorite"),
                    ));
            },
            icon: Icon(
              widget.isMealFavorite(mealId) ? Icons.star : Icons.star_border,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("${selectMeal.duration} min"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("$complexityText"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("$affordabilityText"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(ctx).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      selectMeal.ingredients[index],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                itemCount: selectMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}"),
                      ),
                      title: Text(selectMeal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectMeal.steps.length,
              ),
            ),
            Container(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.saveDeleteId(mealId);
          Navigator.of(context).pop(mealId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Deleted"),
          ));
        },
        //Test Cart
        // child: Icon(Icons.shopping_bag),
        child: Icon(Icons.delete),
      ),
    );
  }
}
