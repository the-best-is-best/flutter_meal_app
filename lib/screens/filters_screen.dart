import 'package:flutter/material.dart';
import '../widgets/min_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filter";
  final Function saveFilters;
  final currentFilters;

  const FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vagan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String subTitle, bool currentValue, dynamic updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final Map<String, bool> selectedFulters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vagan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFulters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten-Free',
                  'Only gluten-free meals.',
                  _glutenFree,
                  (newvalue) {
                    setState(() {
                      _glutenFree = newvalue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Lactose-Free',
                  'Only lactose-Free meals.',
                  _lactoseFree,
                  (newvalue) {
                    setState(() {
                      _lactoseFree = newvalue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian',
                  'Only vegetarian Meals.',
                  _vegetarian,
                  (newvalue) {
                    setState(() {
                      _vegetarian = newvalue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Vegan',
                  'Only vegan meals.',
                  _vegan,
                  (newvalue) {
                    setState(() {
                      _vegan = newvalue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MinDrawer(),
    );
  }
}
