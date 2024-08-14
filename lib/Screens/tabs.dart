import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mealsapp/Screens/categories.dart';
import 'package:mealsapp/Screens/filtersScreen.dart';
import 'package:mealsapp/Screens/meals.dart';
import 'package:mealsapp/provider/favouriteNotifier.dart';
import 'package:mealsapp/provider/filtersprovider.dart';
import 'package:mealsapp/provider/meals_provider.dart';
import 'package:mealsapp/widgets/mainDrawer.dart';

const kInitialvalue = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  var _selectedIndex = 0;

 

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(meals_Provider);
    final activeFilters = ref.watch(filtersProvider);
    // ignore: no_leading_underscores_for_local_identifiers
    final _availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      } else {
        return true;
      }
    }).toList();

    Widget activeScreen = CategoriesScreen(
      availablemeal: _availableMeals,
    );
    String initialTitle = 'Categories';
    if (_selectedIndex == 1) {
      final favouriteMeals = ref.watch(favouritemealsProvider);
      activeScreen = Meals(
        meals: favouriteMeals,
      );
      initialTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(initialTitle),
      ),
      drawer: MainDawer(onSelectScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTab,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Cateories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
