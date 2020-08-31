import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/chefDishesViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/dishViewSingleDesign.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingNoBg.dart';
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
    final _chefData = Provider.of<ChefData>(context);
    final _user = Provider.of<User>(context);

    int count = 0;
    print("---------> _chefData inside chefDishes: " + _chefData.toString());
    String _chefName;
    return BaseView<ChefDishesViewmodel>(
        //  onModelReady: (model) => model.isDishAvalaible(),
        builder: (context, model, child) =>
            // model.state == ViewState.Busy
            //     ? Loading()
            //     : model.isDishAvalaible()
            //         ?

            ResponsiveSafeArea(
              builder: (context, widgetSize) => Scaffold(
                body: ListView(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.push((context),
                          MaterialPageRoute(builder: (context) => AddDish())),
                      child: Text("Add new dish"),
                    ),
                    // -----------
                    Container(
                      padding: EdgeInsets.only(left: widgetSize.width * 0.025),
                      child: StandardHeadingNoBg(
                        passedText: "Available dishes",
                      ),
                    ),
                    // -----------
                    _chefData == null && _chefDish == null
                        ? Loading()
                        : _chefData.hasDish
                            ? Column(
                                children: _chefDish.map((dish) {
                                  count += 1;

                                  print("-------->count " + count.toString());

                                  if (dish.chefID == _chefData.chefID) {
                                    print(
                                        ">>>>>>>>>>>> dish Data inside chefDishesView: " +
                                            dish.chefName +
                                            " " +
                                            dish.dishName +
                                            " " +
                                            dish.dishPrice.toString() +
                                            " " +
                                            dish.dishPic.toString());
                                    // print(
                                    //     ">>>>>>>>>>>> dish.chefName inside chefDishesView: " +
                                    //         _chefName.toString());

                                    print(
                                        ">>>>>>>>>>>> chefID and current user inside chefDishesView: " +
                                            dish.chefID +
                                            " - " +
                                            _user.uid);

                                    return Container(
                                      // margin: EdgeInsets.symmetric(
                                      //   vertical: widgetSize.height * 0.0,
                                      // ),
                                      child: DishViewSingleDesign(
                                        dishName: dish.dishName,
                                        // chefName: _chefName,
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
                            : Container(
                                // color: Colors.amber,
                                height: widgetSize.height * 0.75,
                                child: Center(
                                  child: Text("No dishes uploaded by chef yet"),
                                ),
                              ),
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
