import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/chefDishesViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/dishViewSingleDesign.dart';
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
    final _chefDish = Provider.of<List<Dish>>(context);
    return BaseView<ChefDishesViewmodel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
          body: ListView(
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.push((context),
                    MaterialPageRoute(builder: (context) => AddDish())),
                child: Text("Add new dish"),
              ),
              Container(
                padding: EdgeInsets.only(left: widgetSize.width * 0.025),
                child: StandardHeadingNoBg(
                  passedText: "Available dishes",
                ),
              ),
              _chefDish != null
                  ? Column(
                      children: _chefDish.map((dish) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: widgetSize.height * 0.0,
                          ),
                          child: DishViewSingleDesign(
                            dishName: dish.dishName,
                            chefName: "Mister Altaf",
                            kcal: 250.5,
                            price: dish.dishPrice,
                            ratings: 3.5,
                            dishPic: dish.dishPic,
                          ),
                        );
                      }).toList(),
                    )
                  : Center(
                      child: Text("No dishes uploaded by chef yet"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
