import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefProfileView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var dishStreamProvider;
    var chefDataStreamProvider;
    try {
      dishStreamProvider = StreamProvider<Dish>.value(
        value: DatabaseService(uid: user.uid).getDishData,
      );
      chefDataStreamProvider = StreamProvider<ChefData>.value(
        value: DatabaseService(uid: user.uid).getChefData,
      );
    } catch (error) {
      print("-----> Error in ChefProfileMain : " + error.toString());
    }

    return MultiProvider(
      providers: [
        chefDataStreamProvider,
        dishStreamProvider,
      ],
      child: MaterialApp(home: ChefProfileView()),
    );
  }
}
