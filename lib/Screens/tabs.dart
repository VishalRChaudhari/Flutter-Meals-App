import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mealsapp/Screens/categories.dart';
import 'package:mealsapp/Screens/filtersScreen.dart';
import 'package:mealsapp/Screens/meals.dart';
import 'package:mealsapp/model/meal.dart';
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
  final List<Meal> _favouriteMeals = [];

  Map<Filter, bool> _selectedFiters = kInitialvalue;

  void infomessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final _isExisting = _favouriteMeals.contains(meal);
    if (_isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        infomessage('Meal is no longer a favourite');
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        infomessage('Meal is marked as favourite meal');
      });
    }
  }

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) =>  FilterScreen(currentFilter: _selectedFiters),
        ),
      );
      setState(() {
        _selectedFiters = result ?? kInitialvalue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final meals = ref.watch(meals_Provider);
    final _availableMeals = meals.where((meal) {
      if (_selectedFiters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFiters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFiters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFiters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      } else {
        return true;
      }
    }).toList();

    Widget activeScreen = CategoriesScreen(
      toggleMealFavouriteStatus: _toggleMealFavouriteStatus,
      availablemeal: _availableMeals,
    );
    String initialTitle = 'Categories';
    if (_selectedIndex == 1) {
      activeScreen = Meals(
        meals: _favouriteMeals,
        toggleMealFavouriteStatus: _toggleMealFavouriteStatus,
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
