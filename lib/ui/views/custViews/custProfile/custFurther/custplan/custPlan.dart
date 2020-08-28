import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/custMeals.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/summaryCard.dart';
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
  String _activitylevel;
  String _activitylevelWORKOUT;
  SingingCharacter _character = SingingCharacter.female;

  List<Widget> mealsList;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _planData = Provider.of<Plan>(context);

    mealsList = [CustMeals(), CustMeals()];

    return Scaffold(
      body: Builder(
        builder: (BuildContext newContext) {
          return BaseView<CustPlanViewModel>(
              builder: (newContext, model, child) => ResponsiveSafeArea(
                    builder: (newContext, widgetSize) => Container(
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

                          SizedBox(
                            height: widgetSize.height * 0.02,
                          ),
                          Text(
                            "Goals:",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: widgetSize.height * 0.05,
                              color: Color(0xff4d3814).withOpacity(0.71),
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(left: widgetSize.width * 0.1),
                            child: Column(
                              children: <Widget>[
                                standardInfDisplaywithBullets(
                                    'Weight :',
                                    _planData.custGoalWeight.toString() + 'Kg',
                                    deviceSize),
                                standardInfDisplaywithBullets(
                                    'Calories :',
                                    _planData.custHeight.toString(),
                                    deviceSize),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widgetSize.height * 0.02,
                          ),
                          Text(
                            "Meals:",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: widgetSize.height * 0.05,
                              color: Color(0xff4d3814).withOpacity(0.71),
                            ),
                          ),

                          ///
                          /// M  E  A  L  S -- W   I   D  G  E  T \\
                          ///
                          ///
                          // Container(
                          //   height: widgetSize.height * 0.9,
                          //   width: widgetSize.width,
                          //   child: Swiper(
                          //     itemCount: 2,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return mealsList[index];
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}
