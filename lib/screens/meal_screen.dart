import 'package:flutter/material.dart';
import 'package:some_app/screens/meal_details_screen.dart';

import 'package:some_app/widgets/meal_item.dart';
import '../models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    this.title,
    required this.meals,
    
    super.key,
  });

  final List<Meal> meals;
  final String? title;
  

  

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 2 / 2,
      ),
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          selectMeal(context, meal);
        },
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nothing to see here",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              "Try selecting a different meal",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      );
      if (title == null){
        return content;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick a meal",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      body: content,
    );
  }
}
