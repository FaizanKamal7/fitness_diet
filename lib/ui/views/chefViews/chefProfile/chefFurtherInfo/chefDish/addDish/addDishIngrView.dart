import 'dart:io';

import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/FoodCentralJSONModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/apiIngrViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/ingrSearchView.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class AddDishIngrView extends StatefulWidget {
  // void getIng() async {
  //   allFoodIngrList = await IngrViewModel().getAllIngredientsList();
  //   print("_foodNutrient: " + allFoodIngrList.toString());
  // }

  String dishCatg;
  int prepTimeHrs, prepTimeMin, totalPrepTime;
  File dishPic;

  TextEditingController dishNameContr = TextEditingController();
  TextEditingController priceContr = TextEditingController();
  TextEditingController attrContr = TextEditingController();
  AddDishIngrView();
  AddDishIngrView.withDishInfo({
    @required this.dishPic,
    @required this.dishNameContr,
    @required this.priceContr,
    @required this.totalPrepTime,
    @required this.dishCatg,
    @required this.attrContr,
  });

  // AddDishIngrView.withIngr({
  //   @required this.allFoodIngrList,
  // });
  @override
  _AddDishIngrViewState createState() => _AddDishIngrViewState();
}

class _AddDishIngrViewState extends State<AddDishIngrView> {
  List<FoodInfo> _currentIngrList;
  Map<int, int> countValues = {};
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return BaseView<IngrViewModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : Container(
              padding: EdgeInsets.only(
                left: deviceSize.width * 0.04,
                top: deviceSize.height * 0.04,
                right: deviceSize.height * 0.04,
                bottom: deviceSize.height * 0.07,
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // setState(() {
                      //   _ingrBtnClickCount += 1;
                      // });
                      // _currentIngrList =
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IngredientsSearchView(),
                        ),
                      ).then((value) {
                        setState(() {
                          _currentIngrList = model.getCurrentFoodIngr;
                          print("------- INSIDE setState : " +
                              _currentIngrList.toString());
                        });
                        // Assigning value 1 to default selected ingredients
                        List<FoodInfo> tempList = model.getCurrentFoodIngr;
                        for (int i = 0;
                            i < model.getCurrentFoodIngr.length;
                            i++) {
                          countValues[tempList[i].fdcId] = 1;
                        }
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(deviceSize.height * 0.15)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceSize.width * 0.05),
                        height: deviceSize.height * 0.04,
                        width: deviceSize.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.3,
                              blurRadius: 10,
                              offset:
                                  Offset(2, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text("Select Ingredients"),
                        ),
                      ),
                    ),
                  ),
                  model.getCurrentFoodIngr.length != 0
                      ? Container(
                          height: deviceSize.height * 0.7,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.getCurrentFoodIngr.length,
                            itemBuilder: (context, index) {
                              FoodInfo _singleIngr =
                                  model.getCurrentFoodIngr[index];

                              return Container(
                                  // color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    title: Text(
                                        _singleIngr.description.toString()),
                                    subtitle: Text(
                                      ConstantFtns().getStringAfterCharacter(
                                              _singleIngr
                                                  .foodNutrients[3].amount
                                                  .toString(),
                                              " ") +
                                          " " +
                                          ConstantFtns()
                                              .getStringAfterCharacter(
                                                  _singleIngr
                                                      .foodNutrients[3].unitName
                                                      .toString(),
                                                  ".") +
                                          " \n" +
                                          _singleIngr.additionalDescriptions
                                              .toString(),
                                    ),
                                    trailing: Container(
                                      margin: EdgeInsets.only(bottom: 10.0),
                                      alignment: Alignment.center,
                                      height: 25.0,
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xffE4E4E4),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                countValues[
                                                    _singleIngr.fdcId] -= 1;

                                                if (countValues[
                                                        _singleIngr.fdcId] <
                                                    0) {
                                                  countValues[
                                                      _singleIngr.fdcId] = 0;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.green,
                                            ),
                                          ),
                                          // Spacer(),
                                          Text(countValues[_singleIngr.fdcId]
                                              .toString()),
                                          // --------------------------------------- A D D   I T E M
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                countValues[
                                                    _singleIngr.fdcId] += 1;
                                              });
                                            },
                                            child: Icon(Icons.add_circle,
                                                color: Colors.green),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        )
                      : Text("Still null"),
                ],
              )
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     StandardHeadingNoBgUniSans(passedText: "Ingredients:"),
                  //     Text("Info: " + widget.dishNameContr.text.toString()),
                  //     SearchableDropdown.multiple(
                  //       // value: foodItem.description,

                  //       selectedItems: selectedItems,
                  //       hint: Padding(
                  //         padding: const EdgeInsets.all(12.0),
                  //         child: Text("Select any"),
                  //       ),
                  //       searchHint: "Select any",
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedItems = value;
                  //           print("selecteditems: " + selectedItems.toString());
                  //         });
                  //       },
                  //       items: allFoodIngrList.map((foodItem) {
                  //         return DropdownMenuItem<String>(
                  //             child: Card(
                  //           margin: EdgeInsets.all(10),
                  //           child: Container(
                  //             color: Color(0xffFFFBF3),
                  //             padding: EdgeInsets.all(15),
                  //             child: ListTile(
                  //               title: Text(foodItem.description),
                  //               subtitle: Text(foodItem.foodNutrients[0].name),
                  //             ),
                  //           ),
                  //         ));
                  //       }).toList(),
                  //     ),

                  //     // selectedItems.map((value) => Text(value.toString()));
                  //     // ListView.builder(
                  //     //   shrinkWrap: true,
                  //     //   itemBuilder: (context, index) {
                  //     //     return Text(selectedItems[index].toString());
                  //     //   },
                  //     // )
                  //   ],
                  // ),

                  ),
            ),
    );
  }
}
