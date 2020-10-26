import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/addExerciseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/addMeal.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/custMeals.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/cutsExercises.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/summaryCard.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingwithBGandRoundCorner.dart';
import 'package:fitness_diet/ui/widgets/standardInfoDisplayWithBullets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class CustPlan extends StatefulWidget {
  @override
  _CustPlanState createState() => _CustPlanState();
}

enum SingingCharacter { male, female }

class _CustPlanState extends State<CustPlan> {
  Size widgetSize;
  // String _activitylevel;
  // String _activitylevelWORKOUT;
  // SingingCharacter _character = SingingCharacter.female;

  List<Widget> mealsList;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _planData = Provider.of<Plan>(context);

    mealsList = [CustMeals(), CustMeals()];
    String previousdate;
    String previousdateMeals;

    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: widgetSize.height * 0.02,
                  left: widgetSize.width * 0.04,
                  right: widgetSize.width * 0.04),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        "Summary:",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.05,
                          color: Color(0xff4d3814).withOpacity(0.71),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "DETAILS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.04,
                          color: Color(0xff7a7cb0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widgetSize.height * 0.02,
                  ),
                  // S  U  M  M  A  R   Y  ----- C  A  R  D  //
                  SummaryCard(widgetSize),
                  //
                  //
                  // B  O  D  Y ----- M  E  A  S  U  R  E  M  E  N  T ------------------------------
                  //
                  //
                  SizedBox(
                    height: widgetSize.height * 0.03,
                  ),
                  standardHeadingWithBGAndRoundCorner(
                      passedText: 'Body Measurement'),
                  SizedBox(
                    height: widgetSize.height * 0.03,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: widgetSize.width * 0.1),
                    child: Column(
                      children: <Widget>[
                        standardInfDisplaywithBullets(
                            'Weight :',
                            _planData.custWeight.toString() + "  Kg",
                            deviceSize),
                        standardInfDisplaywithBullets(
                            'Height :',
                            _planData.custHeight.toString() + '  inch',
                            deviceSize),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widgetSize.height * 0.03,
                  ),
                  standardHeadingWithBGAndRoundCorner(passedText: 'Goals'),
                  SizedBox(
                    height: widgetSize.height * 0.03,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: widgetSize.width * 0.1),
                    child: Column(
                      children: <Widget>[
                        standardInfDisplaywithBullets(
                            'Weight :',
                            _planData.custGoalWeight.toString() + 'Kg',
                            deviceSize),
                        standardInfDisplaywithBullets('Calories :',
                            _planData.custHeight.toString(), deviceSize),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widgetSize.height * 0.02,
                  ),
                  standardHeadingWithBGAndRoundCorner(passedText: 'Meals'),
                  SizedBox(
                    height: widgetSize.height * 0.04,
                  ),

                  // /
                  // / M  E  A  L  S -- W   I   D  G  E  T \\
                  // /

                  Container(
                    // color: Colors.red,
                    height: widgetSize.height * 0.9,
                    width: widgetSize.width,
                    child: Swiper(
                      loop: false,
                      // pagination: new SwiperPagination(),
                      itemCount:
                          model.getUnigueDateCount(_planData.custMeals) < 7
                              ? model.getUnigueDateCount(_planData.custMeals)
                              : 7,
                      itemBuilder: (BuildContext context, int index) {
                        // geting list of exercise on the same day

                        if (previousdateMeals !=
                            model.formateDateForDifference(
                                _planData.custMeals.keys.elementAt(index))) {
                          Map<String, dynamic> newList = model.getExerciseList(
                              _planData.custMeals.keys.elementAt(index),
                              _planData.custMeals);
                          previousdateMeals = model.formateDateForDifference(
                              _planData.custMeals.keys.elementAt(index));
                          print(
                              '---------------------------------new list length in list builder in meals ' +
                                  newList.length.toString());
                          return CustMeals(mealsList: newList);
                          //

                        }
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      print('add Meal presed :');
                      // _showAddressBottomSheet(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (Context) => AddMealView()),
                      );
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add Meal",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Color(0xff3caa43),
                          ),
                        )),
                  ),
                  standardHeadingWithBGAndRoundCorner(passedText: 'Exercise '),
                  SizedBox(
                    height: widgetSize.height * 0.04,
                  ),

                  // --------------------------- > E X E C I S E --W I D G E T
                  //
                  Container(
                    // color: Colors.red,
                    height: widgetSize.height * 0.9,
                    width: widgetSize.width,
                    child: Swiper(
                      loop: false,
                      // pagination: new SwiperPagination(),
                      itemCount:
                          model.getUnigueDateCount(_planData.custExercise) < 7
                              ? model.getUnigueDateCount(_planData.custExercise)
                              : 7,
                      itemBuilder: (BuildContext context, int index) {
                        // geting list of exercise on the same day

                        if (previousdate !=
                            model.formateDateForDifference(
                                _planData.custExercise.keys.elementAt(index))) {
                          Map<String, dynamic> newList = model.getExerciseList(
                              _planData.custExercise.keys.elementAt(index),
                              _planData.custExercise);
                          previousdate = model.formateDateForDifference(
                              _planData.custExercise.keys.elementAt(index));
                          print(
                              '---------------------------------new list length in list builder' +
                                  newList.length.toString());
                          return CustExercise(exerciseList: newList);
                          //

                        }
                      },
                    ),
                  ),

                  FlatButton(
                    onPressed: () {
                      print('add exercise presed :');
                      // _showAddressBottomSheet(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (Context) => AddExerciseView()),
                      );
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add Exercise",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            color: Color(0xff3caa43),
                          ),
                        )),
                  ),
                ],
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
