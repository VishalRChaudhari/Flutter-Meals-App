import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilter});

  final Map<Filter, bool> currentFilter;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilter[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilter[Filter.lactoseFree]!;
    _veganFilterSet = widget.currentFilter[Filter.vegan]!;
    _vegetarianFilterSet = widget.currentFilter[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didpop) {
          if (didpop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
          });
        },
        child: Column(
          children: [
            //1
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (ischecked) {
                setState(() {
                  _glutenFreeFilterSet = ischecked;
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'only includes gluten-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            //2
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (ischecked) {
                setState(() {
                  _lactoseFreeFilterSet = ischecked;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'only includes Lactose-free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            //3
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (ischecked) {
                setState(() {
                  _vegetarianFilterSet = ischecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'only includes vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
            //4
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (ischecked) {
                setState(() {
                  _veganFilterSet = ischecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'only includes vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),
            ),
          ],
        ),
      ),
    );
  }
}
