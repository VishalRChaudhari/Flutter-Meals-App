import 'package:flutter/material.dart';
import 'package:mealsapp/Screens/meals.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/model/category.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/widgets/categorygridview.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.toggleMealFavouriteStatus,
      required this.availablemeal});

  final void Function(Meal meal) toggleMealFavouriteStatus;
  final List<Meal> availablemeal;

  void _onSelectCategory(BuildContext context, Category category) {
    final filteredlist = availablemeal
        .where((Meal) => Meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Meals(
          title: category.title,
          meals: filteredlist,
          toggleMealFavouriteStatus: toggleMealFavouriteStatus,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryListview(
              category: category,
              onSelectCategory: () {
                _onSelectCategory(context, category);
              }),
      ],
    );
  }
}
