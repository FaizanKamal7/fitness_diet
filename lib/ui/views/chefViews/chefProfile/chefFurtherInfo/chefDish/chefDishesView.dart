import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/chefDishesViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/soleDishView.dart';
import 'package:fitness_diet/ui/widgets/dishViewSingleListItemDesign.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addDish/addDishInfoView.dart';

class ChefDishes extends StatefulWidget {
  @override
  _ChefDishesState createState() => _ChefDishesState();
}

class _ChefDishesState extends State<ChefDishes> {
  @override
  Widget build(BuildContext context) {
    final _chefDish = Provider.of<List<Dish>>(context);
    final _chefData = Provider.of<List<ChefData>>(context);
    final _user = Provider.of<CurrentUser>(context);

    int count = 0;
    print("---------> _chefData inside chefDishes: " + _chefData.toString());

    return BaseView<ChefDishesViewmodel>(
        onModelReady: (model) async {
          String currentChefID = model.getUser;
          print("currentChefID: " + currentChefID.toString());
          // _chefData = model.getSingleChefData(currentChefID);
          // print("inOnModelReady : " + _chefData.first.toString());
        },
        builder: (context, model, child) => ResponsiveSafeArea(
              builder: (context, widgetSize) => Scaffold(
                body: ListView(
                  children: <Widget>[
                    // ----------- A D D   D I S H   B T N
                    FlatButton(
                      onPressed: () => Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => AddDishInfo())),
                      child: Text("Add new dish"),
                    ),
                    // ----------- A V A L A I B L E   D I S H E S   H E A D I N G
                    Container(
                      padding: EdgeInsets.only(left: widgetSize.width * 0.025),
                      child: StandardHeadingNoBg(
                        passedText: "Available dishes",
                      ),
                    ),
                    // ----------- D I S H E S   L I S T
                    SizedBox(height: 15),
                    _chefDish == null
                        ? Loading()
                        : Column(
                            children: _chefDish.map((dish) {
                              count += 1;

                              if (dish.chefID == _user.uid) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SoleDishView(
                                          passedDish: dish,
                                          isFromCustView: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: DishViewSingleListItemDesign(
                                    dishName: dish.dishName,
                                    chefName: dish.chefName,
                                    kcal: 250.5,
                                    price: dish.dishPrice,
                                    ratings: 3.5,
                                    dishPic: dish.dishPic,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }).toList(),
                          )
                  ],
                ),
              ),
            )
        // : Material(
        //     child: Container(
        //       child: Center(
        //         child: Text("No dishes yet"),
        //       ),
        //     ),
        //   ),
        );
  }
}
