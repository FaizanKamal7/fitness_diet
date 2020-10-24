import 'dart:io';

import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/FoodCentralJSONModel.dart';
import 'package:fitness_diet/core/viewmodels/chefProfileViewModels/chefDishViewModels/addDishViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/apiIngrViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/addDish/ingrSearchView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/Buttons/standardBtnWhitishRound.dart';

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

    return BaseView<AddDishViewModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : Container(
              padding: EdgeInsets.only(
                left: deviceSize.width * 0.02,
                top: deviceSize.height * 0.02,
                right: deviceSize.height * 0.04,
                //   bottom: deviceSize.height * 0.07,
              ),
              child: Stack(
                children: [
                  // --------------------------------- S E A R C H    I N G R E D I E N T S
                  InkWell(
                    onTap: () {
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
                        List<FoodInfo> tempList = _currentIngrList;
                        for (int i = 0; i < _currentIngrList.length; i++) {
                          countValues[tempList[i].fdcId] = 1;
                          print("countValues : " + countValues.toString());
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
                  // ---------------------------------  I N G R E D I E N T S   L I S T
                  Container(
                    margin: EdgeInsets.only(
                      top: deviceSize.height * 0.04,
                      bottom: deviceSize.height * 0.08,
                    ),
                    height: deviceSize.height * 0.7,
                    child: _currentIngrList != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: _currentIngrList.length,
                            itemBuilder: (context, index) {
                              FoodInfo _singleFood = _currentIngrList[index];
                              print(
                                  "##################### ADDING IN _currentIngrList. _singleFood : " +
                                      _singleFood.fdcId.toString());
                              // _currentIngrList.add(
                              //     _singleFood); // Transferring API list data to class level list
                              // * G E T T I N G   N U T R I E N T S   V A L U E S
                              // >>>>>>>>>>>>>>>>> Removing unnessecary title
                              String _caloriesOriginalAmount = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[3].amount
                                          .toString(),
                                      " ");
                              String _proteinOriginalAmount = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[0].amount
                                          .toString(),
                                      " ");
                              String _fatsOriginalAmount = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[1].amount
                                          .toString(),
                                      " ");
                              String _carbsOriginalAmount = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[2].amount
                                          .toString(),
                                      " ");
                              // >>>>>>>>>>>>>>>>> Assigning Actual values
                              // --- Calories data
                              double _caloriesAmount =
                                  double.parse(_caloriesOriginalAmount) *
                                      countValues[_singleFood.fdcId];

                              _currentIngrList[index].foodNutrients[3].amount =
                                  _caloriesAmount; // Updating nutrient data in class level list on selecting multiples

                              print(
                                  "##################### _currentIngrList foodNutrients. amount : " +
                                      _currentIngrList[index]
                                          .foodNutrients[3]
                                          .amount
                                          .toString());

                              String _caloriesUnit = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[3].unitName
                                          .toString(),
                                      ".");
                              // --- Protein data
                              double _proteinAmount =
                                  double.parse(_proteinOriginalAmount) *
                                      countValues[_singleFood.fdcId];

                              _currentIngrList[index].foodNutrients[0].amount =
                                  _proteinAmount; // Updating nutrient data in class level list on selecting multiples

                              String _proteinUnit = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[0].unitName
                                          .toString(),
                                      ".");
                              // --- Fats data
                              double _fatsAmount =
                                  double.parse(_fatsOriginalAmount) *
                                      countValues[_singleFood.fdcId];

                              _currentIngrList[index].foodNutrients[1].amount =
                                  _fatsAmount; // Updating nutrient data in class level list on selecting multiples

                              String _fatsUnit = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[1].unitName
                                          .toString(),
                                      ".");
                              // --- Carbs data
                              double _carbsAmount =
                                  double.parse(_carbsOriginalAmount) *
                                      countValues[_singleFood.fdcId];

                              _currentIngrList[index].foodNutrients[2].amount =
                                  _carbsAmount; // Updating nutrient data in class level list on selecting multiples
                              String _carbsUnit = ConstantFtns()
                                  .getStringAfterCharacter(
                                      _singleFood.foodNutrients[2].unitName
                                          .toString(),
                                      ".");
                              // * S E T T I N G   N U T R I E N T S   V A L U E S
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title:
                                      Text(_singleFood.description.toString()),
                                  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  N U T R I E N T   I N F O
                                  subtitle: Text(
                                    _caloriesAmount.toString() +
                                        " " +
                                        _caloriesUnit +
                                        ", Prot: " +
                                        _proteinAmount.toString() +
                                        " " +
                                        _proteinUnit +
                                        ", Carbs " +
                                        _carbsAmount.toString() +
                                        " " +
                                        _carbsUnit +
                                        ", Fats " +
                                        _fatsAmount.toString() +
                                        " " +
                                        _fatsUnit +
                                        " \nper 100g",
                                  ),
                                  // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> A D D   /   R E M O V E   B U T T O N
                                  trailing: Container(
                                    margin: EdgeInsets.only(bottom: 10.0),
                                    alignment: Alignment.center,
                                    height: 25.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE4E4E4),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // --- Remove button
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              countValues[_singleFood.fdcId] -=
                                                  1;

                                              if (countValues[
                                                      _singleFood.fdcId] <
                                                  0) {
                                                countValues[_singleFood.fdcId] =
                                                    0;
                                                print(
                                                    "_singleFood.fdcId in remove count : " +
                                                        countValues[_singleFood
                                                                .fdcId]
                                                            .toString());
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                        // --- Ingredient
                                        Text(countValues[_singleFood.fdcId]
                                            .toString()),
                                        // --- Add button
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              countValues[_singleFood.fdcId] +=
                                                  1;
                                            });
                                            print(
                                                "_singleFood.fdcId in add count : " +
                                                    countValues[
                                                            _singleFood.fdcId]
                                                        .toString());
                                          },
                                          child: Icon(Icons.add_circle,
                                              color: Colors.green),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: Text("Select ingredients to proceed")),
                  ),
                  // --------------------------------------- U P L O A D    B U T T O N
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.white,
                      padding: EdgeInsets.all(20),
                      height: deviceSize.height * 0.08,
                      width: deviceSize.width,
                      //  margin: EdgeInsets.only(bottom: deviceSize.height * 0.02),
                      child: FlatButton(
                        onPressed: () async {
                          print(
                              "------ dishPic inside onPressed  of addDishView.dart : " +
                                  widget.dishPic.toString());
                          model.uploadDishInfo(
                            widget.dishNameContr.text,
                            int.parse(widget.priceContr.text),
                            widget.totalPrepTime,
                            widget.dishPic,
                            widget.dishCatg,
                            widget.attrContr.text,
                            _currentIngrList,
                          );
                        },
                        child: AuthBtnStyle(
                          deviceSize: deviceSize,
                          passedText: "Upload",
                        ),
                      ),
                    ),
                  ),

                  model.hasErrorMessage
                      ? Container(
                          color: Colors.red,
                          child: Text(
                            model.errorMessage,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
                  model.state == ViewState.Busy ? Loading() : Container(),
                ],
              ),
            ),
    );
  }
}
