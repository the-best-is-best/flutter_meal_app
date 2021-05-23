import 'package:flutter/material.dart';
//Test Cart
// import '../models/cart.dart';
// import 'cart_items_screen.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category_meals";
  final List<Meal> avaliableMeal;
  const CategoryMealsScreen(this.avaliableMeal);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = "";
  List<Meal> displayMeal = [];
  @override
  void didChangeDependencies() {
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;

    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title'].toString();
    displayMeal = widget.avaliableMeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeItem(int id) {
    setState(() {
      displayMeal.removeWhere((meal) => meal.id == id);
    });
  }

//Test Cart
  // void _addToCart(int id) {
  //   Meal puyMeal = DUMMY_MEALS.firstWhere((meal) {
  //     return meal.categories.contains(id);
  //   });
  //   Cart.cartMeal.add(puyMeal);
  //   print(Cart.cartMeal.length);
  //   setState(() {
  //     Cart.cartCount = Cart.cartMeal.length;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Meals - $categoryTitle"),
        //Test Cart
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.all(10.0),
        //     child: Container(
        //       height: 150.0,
        //       width: 30.0,
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.of(context).push(
        //             new MaterialPageRoute(
        //               builder: (BuildContext context) => CartItemsScreen(
        //                 displayCart: //Cart.cartMeal,
        //               ),
        //             ),
        //           );
        //         },
        //         child: Stack(
        //           children: <Widget>[
        //             IconButton(
        //               icon: Icon(
        //                 Icons.shopping_cart,
        //                 color: Colors.white,
        //               ),
        //               onPressed: null,
        //             ),
        //             Positioned(
        //                 child: Stack(
        //               children: <Widget>[
        //                 Icon(Icons.brightness_1,
        //                     size: 20.0, color: Colors.green[800]),
        //                 Positioned(
        //                     top: 3.0,
        //                     right: 6.0,
        //                     child: Center(
        //                       child: Text(
        //                       //  Cart.cartCount.toString(),
        //                         style: TextStyle(
        //                             color: Colors.white,
        //                             fontSize: 11.0,
        //                             fontWeight: FontWeight.w500),
        //                       ),
        //                     )),
        //               ],
        //             )),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: displayMeal[index].id,
          imageUrl: displayMeal[index].imageUrl,
          title: displayMeal[index].title,
          duration: displayMeal[index].duration,
          complexity: displayMeal[index].complexity,
          affordability: displayMeal[index].affordability,
          removeItem: _removeItem,
        ),
        itemCount: displayMeal.length,
      ),
    );
  }
}
