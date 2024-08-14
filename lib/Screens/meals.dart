import 'package:flutter/material.dart';
import 'package:mealsapp/Screens/mealdetailsScreen.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/widgets/MealItem.dart';

class Meals extends StatelessWidget {
  const Meals(
      {super.key,
      this.title,
      required this.meals,
      required this.toggleMealFavouriteStatus});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) toggleMealFavouriteStatus;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          meal: meal,
          toggleMealFavouriteStatus: toggleMealFavouriteStatus,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh ohh... nothing here! ',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Try Selecting a different Category',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (context, index) => Mealitem(
            meal: meals[index],
            onSelectmeal: (meal) {
              selectMeal(context, meal);
            }),
        itemCount: meals.length,
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
