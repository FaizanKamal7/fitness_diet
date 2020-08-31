import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/foodMenuView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodMenuMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("------> FoodMenuMain REACHED");
    var dishStreamProvider;

    try {
      // - Dish data stream
      dishStreamProvider = StreamProvider<List<Dish>>.value(
          value: DatabaseService().getAllDishData);
    } catch (error) {
      print("-----> Error in ChefProfileMain : " + error.toString());
    }
    return MultiProvider(
      providers: [
        dishStreamProvider,
      ],
      child: MaterialApp(home: FoodMenuView()),
    );
  }
}
