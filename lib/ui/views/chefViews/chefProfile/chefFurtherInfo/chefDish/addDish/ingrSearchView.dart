import 'package:custom_switch/custom_switch.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/models/FoodCentralJSONModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/apiIngrViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/bigLightGreenBtn.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithoutPrefix.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBgUniSan.dart';
import 'package:flutter/material.dart';

class IngredientsSearchView extends StatefulWidget {
  @override
  _IngredientsSearchViewState createState() => _IngredientsSearchViewState();
}

class _IngredientsSearchViewState extends State<IngredientsSearchView> {
  List<FoodInfo> allFoodIngrList = [];
  List<FoodInfo> selectedFoodInfoList = [];
  TextEditingController searchedIng = TextEditingController();
  bool isTextFeildEmpty = false;
  bool isLoading = false;
  bool addStatus = false;

  Map<int, bool> selectionStatus = {};
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<IngrViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          // padding: EdgeInsets.symmetric(horizontal: 20),

          child: Stack(
            children: [
              // ------------------------- F O O D   I N F O   L I S T
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.12),
                child: ListView(
                  children: [
                    SizedBox(height: 20),

                    // >>>>>>>>>>>>>>>>>>>>>>>>> F O O D   I N F O
                    isLoading
                        ? Loading()
                        : isTextFeildEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error,
                                      size: 15,
                                      color: Colors.red.withOpacity(0.8)),
                                  Text(
                                    " Textfeild is empty",
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              )
                            : allFoodIngrList != null
                                ? Column(
                                    children: allFoodIngrList
                                        .map(
                                          (singleFood) => Container(
                                            margin: EdgeInsets.all(5),
                                            child: CheckboxListTile(
                                              title:
                                                  Text(singleFood.description),
                                              activeColor: Colors.green,
                                              subtitle: Text(
                                                ConstantFtns()
                                                        .getStringAfterCharacter(
                                                            singleFood
                                                                .foodNutrients[
                                                                    3]
                                                                .amount
                                                                .toString(),
                                                            " ") +
                                                    " " +
                                                    ConstantFtns()
                                                        .getStringAfterCharacter(
                                                            singleFood
                                                                .foodNutrients[
                                                                    3]
                                                                .unitName
                                                                .toString(),
                                                            ".") +
                                                    " \n" +
                                                    singleFood
                                                        .additionalDescriptions
                                                        .toString(),
                                              ),

                                              value: selectionStatus[
                                                  singleFood.fdcId],
                                              onChanged: (val) {
                                                setState(() {
                                                  selectionStatus[
                                                      singleFood.fdcId] = val;
                                                });
                                                selectionStatus[
                                                        singleFood.fdcId]
                                                    ? selectedFoodInfoList
                                                        .add(singleFood)
                                                    : selectedFoodInfoList
                                                        .remove(singleFood);
                                              },

                                              // trailing: Container(
                                              //   height: 40,
                                              //   width: 60,
                                              //   child: Center(
                                              //     child: FlutterSwitch(
                                              //       value: addStatus,
                                              //       onToggle: (val) {
                                              // val
                                              //     ? selectedFoodInfoList
                                              //         .add(singleFood.fdcId)
                                              //     : selectedFoodInfoList
                                              //         .remove(
                                              //             singleFood.fdcId);
                                              //         print("singleFood.fdcId:" +
                                              //             singleFood.fdcId
                                              //                 .toString() +
                                              //             " selectedFoodInfoList: " +
                                              //             selectedFoodInfoList
                                              //                 .toString());
                                              //       },
                                              //     ),
                                              //   ),
                                              // ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : Container(
                                    child: Center(
                                      child: Text(
                                        "No result for particular search",
                                      ),
                                    ),
                                  ),
                  ],
                ),
              ),

              // >>>>>>>>>>>>>>  Add ingredients button
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    model.setIngList(selectedFoodInfoList);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 70,
                    width: deviceSize.width,
                    padding: EdgeInsets.all(20),
                    //    margin: EdgeInsets.only(bottom: 30),
                    color: Colors.white,
                    child: BigLightGreenBtn(
                      passedText: "Add ingredients",
                      isDisabled: false,
                    ),
                  ),
                ),
              ),
              // ------------------------- H E A D E R
              Container(
                height: deviceSize.height * 0.17,
                width: deviceSize.width,
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // >>>>>>>>>>>>>>>>>>>>>>>>> H E A D I N G
                    StandardHeadingNoBgUniSans(
                        passedText: "Search Ingredients: "),

                    // >>>>>>>>>>>>>>>>>>>>>>>>> T E X T F E I L D
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: TextFeildWitouthPrefix(
                            controller: searchedIng,
                            deviceSize: deviceSize,
                            isTypeInt: false,
                            hintText: "Enter ingredient",
                            isObscureText: false,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            color: Colors.black.withOpacity(0.5),
                            icon: Icon(
                              Icons.search,
                              size: deviceSize.height * 0.025,
                              color: Colors.brown.withOpacity(0.7),
                            ),
                            onPressed: () async {
                              if (searchedIng.text.length == 0) {
                                setState(() {
                                  isTextFeildEmpty = true;
                                });
                              } else {
                                setState(() {
                                  isTextFeildEmpty = false;
                                });
                                setState(() {
                                  isLoading = true;
                                });
                                // * Getting the searched food list
                                allFoodIngrList = await IngrViewModel()
                                    .getSearchedIngredientsList(
                                        searchedIng.text);
                                // * Setting the check status of all foods to false
                                if (allFoodIngrList != null) {
                                  for (int i = 0;
                                      i < allFoodIngrList.length;
                                      i++) {
                                    setState(() {
                                      selectionStatus[
                                          allFoodIngrList[i].fdcId] = false;
                                    });
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }

                              print("isTextFeildEmpty: " +
                                  isTextFeildEmpty.toString() +
                                  " and " +
                                  searchedIng.text.length.toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
