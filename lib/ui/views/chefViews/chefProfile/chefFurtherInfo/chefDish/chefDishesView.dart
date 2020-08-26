import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingNoBg.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingwithBGandRoundCorner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addDishView.dart';

class ChefDishes extends StatefulWidget {
  @override
  _ChefDishesState createState() => _ChefDishesState();
}

class _ChefDishesState extends State<ChefDishes> {
  @override
  Widget build(BuildContext context) {
    DatabaseService().getChefDishList();
    final _chefDish = Provider.of<Dish>(context);
    final deviceSize = MediaQuery.of(context).size;
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => ListView(
        children: <Widget>[
          FlatButton(
            onPressed: () => Navigator.push(
                (context), MaterialPageRoute(builder: (context) => AddDish())),
            child: Text("Add new dish"),
          ),
          Container(
            padding: EdgeInsets.only(left: widgetSize.width * 0.025),
            child: StandardHeadingNoBg(
              passedText: "Available dishes",
            ),
          ),
          Column(
            children: [
              Text("_chefDish.dishName.toString()" ?? ""),
              Text("_chefDish.dishPrice.toString()" ?? ""),
              // Text(DatabaseService().getChefDishList()),
            ],
          )
        ],
      ),
    );
  }
}
