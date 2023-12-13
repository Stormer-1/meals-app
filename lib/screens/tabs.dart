import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:some_app/data/dummy_data.dart';
import 'package:some_app/screens/categories.dart';
import 'package:some_app/screens/filter_screen.dart';
import 'package:some_app/screens/meal_screen.dart';
import '../widgets/main_drawer.dart';
//import '../models/meal.dart';

import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;
  
  

  

  

  void _onSelectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
       await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
            
            
          ),
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final availableMeals = ref.watch(filterMealsProvider);

    Widget activePage = CategoriesScreen(
      
      availableMeals: availableMeals,
    );

    var activePageTitle = "Categories";

    if (_selectPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealScreen(
        meals: favoriteMeals,
        
      );
      activePageTitle = "Your favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectPageIndex,
        onTap: _onSelectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
