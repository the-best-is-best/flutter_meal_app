import 'package:flutter/material.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeItem;

  const MealItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.removeItem,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'affordable';
      case Affordability.Luxurious:
        return 'Luxurious';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  void selectMail(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      //Test Cart
      // if (result != null) addToCart(result);
      if (result != null) removeItem(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => selectMail(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      color: Colors.black54,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text("$duration min"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
