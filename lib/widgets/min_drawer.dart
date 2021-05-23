import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class MinDrawer extends StatelessWidget {
  Widget buildListTyle(String title, IconData icon, dynamic tabHandler) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(height: 20),
          buildListTyle('Meal', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTyle('Filters', Icons.filter, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
