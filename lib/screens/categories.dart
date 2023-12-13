import 'package:flutter/material.dart';

import 'package:some_app/data/dummy_data.dart';
import 'package:some_app/screens/meal_screen.dart';
import 'package:some_app/models/meal.dart';
import '../models/category.dart';
import 'package:some_app/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    required this.availableMeals,
    super.key,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // lowerBound: 0,
      // upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSelectACategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meals: filteredMeals,
        ),
      ),
    );
  }

  void onSelectFavorite() {}

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              for (final category in availableCategories)
                CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _onSelectACategory(context, category);
                  },
                )
            ],
          ),
        ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
        child: child,
      ),
      //Padding(
      //   padding: EdgeInsets.only(
      //     top: 100 - _animationController.value * 100,
      //   ),
      //   child: child,
      // ),
    );

    /* child: Scaffold(
        /*appBar: AppBar(
          title: Text(
            "Select a category",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          
        ),*/

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              for (final category in availableCategories)
                CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _onSelectACategory(context, category);
                  },
                )
            ],
          ),
        ),
      ),
    ); */
  }
}
