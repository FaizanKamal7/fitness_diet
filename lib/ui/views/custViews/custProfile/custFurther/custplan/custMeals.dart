import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../baseView.dart';

class CustMeals extends StatefulWidget {
  Map<String, dynamic> mealsList;
  CustMeals({
    @required this.mealsList,
  });
  @override
  _CustMealsState createState() => _CustMealsState();
}

class _CustMealsState extends State<CustMeals> {
  @override
  Widget build(BuildContext context) {
    final _custData = Provider.of<CustData>(context);
    return BaseView<CustPlanViewModel>(
        builder: (context, model, child) => ResponsiveSafeArea(
              builder: (context, widgetSize) => Container(
                // height: widgetSize.height * 0.2,
                width: widgetSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: widgetSize.height * 0.1,
                      width: widgetSize.width,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(widgetSize.height * 0.05),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Image.asset(
                          //   "assets/images/AppIcons/left-arrow.png",
                          //   height: widgetSize.height * 0.05,
                          //   width: widgetSize.height * 0.05,
                          // ),
                          FlatButton(
                            onPressed: null,
                            child: Icon(Icons.arrow_back_ios),
                          ),
                          Text(
                            model.formateDate(
                                widget.mealsList.keys.elementAt(0)),
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: widgetSize.height * 0.05,
                              color: Color(0xff4d3814).withOpacity(0.71),
                            ),
                          ),
                          FlatButton(
                            onPressed: null,
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: widgetSize.height * 0.01,
                    ),
                    //-----------------------  A  D D  B R E A K F A S T ----------------------

                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.mealsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                          ),
                          padding: EdgeInsets.only(left: 10.0),
                          height: widgetSize.height * 0.15,
                          width: widgetSize.width,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 3.00),
                                color: Color(0xff000000).withOpacity(0.16),
                                blurRadius: 6,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(widgetSize.height * 0.05),
                          ),
                          child: Row(
                            children: [
                              // Image.asset(
                              //   "assets/images/AppIcons/breakfast.png",
                              //   height: widgetSize.height * 0.20,
                              //   width: widgetSize.height * 0.20,
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.mealsList.values.elementAt(index)[0],
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: widgetSize.height * 0.045,
                                      color: Color(0xff4d3814),
                                    ),
                                  ),
                                  Text(
                                    "Calories Eaten :" +
                                        widget.mealsList.values
                                            .elementAt(index)[1],
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: widgetSize.height * 0.035,
                                      color:
                                          Color(0xff4d3814).withOpacity(0.38),
                                    ),
                                  ),
                                  // Text(
                                  //   'Duration :' +
                                  //       widget.mealsList.values.elementAt(index)[2],
                                  //   style: TextStyle(
                                  //     fontFamily: "Montserrat",
                                  //     fontSize: widgetSize.height * 0.035,
                                  //     color: Color(0xff4d3814).withOpacity(0.38),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
