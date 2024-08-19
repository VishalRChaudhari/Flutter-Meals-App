import 'package:flutter/material.dart';
import 'package:mealsapp/Screens/meals.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/model/category.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/widgets/categorygridview.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availablemeal});

  final List<Meal> availablemeal;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSelectCategory(BuildContext context, Category category) {
    final filteredlist = widget.availablemeal
        .where((Meal) => Meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Meals(
          title: category.title,
          meals: filteredlist,
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
