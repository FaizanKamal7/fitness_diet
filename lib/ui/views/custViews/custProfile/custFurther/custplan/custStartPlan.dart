import 'dart:ui';

import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';

import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithWhiteBGSmall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../baseView.dart';

class CustStartPlan extends StatefulWidget {
  @override
  _CustStartPlanState createState() => _CustStartPlanState();
}

class _CustStartPlanState extends State<CustStartPlan> {
  double _activitylevel = 1.55;
  //String _activitylevelWORKOUT = 'Average';
  String _gender = 'Female';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _heightControler = TextEditingController();
  TextEditingController _weightControler = TextEditingController();
  TextEditingController _goalWeightControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _custData = Provider.of<CustData>(context);
    return BaseView<CustPlanViewModel>(
      builder: (context, model, child) => SafeArea(
        child: model.state == ViewState.Busy
            ? Loading()
            : Scaffold(
                body: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        //upper header container
                        Container(
                          height: screenSize.height * 0.25,
                          width: screenSize.width,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height * 0.06,
                              ),
                              //
                              //
                              //
                              // ********************* S  T  A  R  T ---- P  L  A  N --------A  N  D --- I  M  A  G  E ------- C  O  N  T  A  I  N  E  R//
                              //
                              //
                              Container(
                                width: screenSize.width,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenSize.width * 0.08,
                                    ),
                                    Text(
                                      "Start\nyour plan",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.05,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    Spacer(),
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.only(
                                    //     bottomLeft: Radius.circular(50),
                                    //     bottomRight: Radius.circular(50),
                                    //   ),
                                    //   child: Container(
                                    //     height: screenSize.height * 0.26,
                                    //     decoration: BoxDecoration(
                                    //       //color: Colors.yellow,
                                    //       image: DecorationImage(
                                    //         image: _custData.custPic != ""
                                    //             ? NetworkImage(_custData.custPic)
                                    //             : AssetImage(custBGImage_1),
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    //     ),
                                    //     child: BackdropFilter(
                                    //       filter: ImageFilter.blur(
                                    //           sigmaX: 9.0, sigmaY: 9.0),
                                    //       child: Container(
                                    //         color: Colors.black.withOpacity(0.5),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: screenSize.width * 0.02,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                        //>>>>>>>> F O R M  -- C O N T A I N E R >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        //
                        //
                        Expanded(
                          flex: 2,
                          child: Container(
                            //height: screenSize.height * 0.609,

                            width: screenSize.width,
                            decoration: BoxDecoration(
                              color: Color(0xffe4d7cb).withOpacity(0.36),
                              borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(screenSize.width * 0.3),
                              ),
                              // boxShadow: [
                              //   BoxShadow(
                              //     offset: Offset(0.01, -0.02),
                              //     color: Color(0xff000000).withOpacity(0.16),
                              //     blurRadius: 2,
                              //   ),
                              // ],
                            ),

                            // container for viewing form  list view
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenSize.height * 0.06),
                              child: Form(
                                child: ListView(
                                  children: <Widget>[
                                    SizedBox(
                                      height: screenSize.height * 0.06,
                                    ),
                                    //container 1 for gender

                                    Container(
                                      margin: EdgeInsets.only(
                                          left: screenSize.width * 0.04),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          //******************************* G  E  N  D  E  R -- C  O  N  T  A  I  N  E  R */
                                          new Text(
                                            "Gender",
                                            style: TextStyle(
                                              fontFamily: "UniSansW01-Regular",
                                              fontSize:
                                                  screenSize.height * 0.031,
                                              color: Color(0xff2a6427),
                                            ),
                                          ),
                                          Container(
                                              child: Row(
                                            children: <Widget>[
                                              Radio(
                                                value: 'Female',
                                                groupValue: _gender,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                              ),
                                              Text(
                                                "Female",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize:
                                                      screenSize.height * 0.026,
                                                  color: Color(0xff000500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenSize.width * 0.09,
                                              ),
                                              Radio(
                                                value: 'Male',
                                                groupValue: _gender,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _gender = value;
                                                  });
                                                },
                                              ),
                                              new Text(
                                                "Male",
                                                style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontSize:
                                                      screenSize.height * 0.026,
                                                  color: Color(0xff000500),
                                                ),
                                              )
                                            ],
                                          )),

                                          //  ******************************************* H  E  I  G  H  T***************************

                                          RichText(
                                            text: TextSpan(
                                                text: 'Height',
                                                style: TextStyle(
                                                  fontFamily:
                                                      "UniSansW01-Regular",
                                                  fontSize:
                                                      screenSize.height * 0.031,
                                                  color: Color(0xff2a6427),
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '(cm)',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "UniSansW01-Regular",
                                                      fontSize:
                                                          screenSize.height *
                                                              0.02,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ]),
                                          ),

                                          SizedBox(
                                            height: screenSize.height * 0.02,
                                          ),
                                          TextFieldWithWhiteBGSmall(
                                              controller: _heightControler,
                                              isTypeInt: true,
                                              hintText: '',
                                              isObscureText: false),

                                          SizedBox(
                                            height: screenSize.height * 0.04,
                                          ),
                                          //<<<<<<<<<<<<<<<<<<<<<<<< W E I G H T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                                          RichText(
                                            text: TextSpan(
                                                text: 'Weight',
                                                style: TextStyle(
                                                  fontFamily:
                                                      "UniSansW01-Regular",
                                                  fontSize:
                                                      screenSize.height * 0.031,
                                                  color: Color(0xff2a6427),
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '(kg)',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "UniSansW01-Regular",
                                                      fontSize:
                                                          screenSize.height *
                                                              0.02,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.02,
                                          ),
                                          TextFieldWithWhiteBGSmall(
                                              controller: _weightControler,
                                              isTypeInt: true,
                                              hintText: '',
                                              isObscureText: false),
                                          SizedBox(
                                            height: screenSize.height * 0.04,
                                          ),
                                          //<<<<<<<<<<<<<<<<<<<<<<<< G O A L - W E I G H T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                                          RichText(
                                            text: TextSpan(
                                                text: 'Goal Weight',
                                                style: TextStyle(
                                                  fontFamily:
                                                      "UniSansW01-Regular",
                                                  fontSize:
                                                      screenSize.height * 0.031,
                                                  color: Color(0xff2a6427),
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '(kg)',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "UniSansW01-Regular",
                                                      fontSize:
                                                          screenSize.height *
                                                              0.02,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            height: screenSize.height * 0.02,
                                          ),
                                          TextFieldWithWhiteBGSmall(
                                              controller: _goalWeightControler,
                                              isTypeInt: true,
                                              hintText: '',
                                              isObscureText: false),

                                          SizedBox(
                                            height: screenSize.height * 0.04,
                                          ),
                                          Text(
                                            "Level of activity during the day\nEXCL. WORKOUTS",
                                            style: TextStyle(
                                              fontFamily: "UniSansW01-Regular",
                                              fontSize:
                                                  screenSize.height * 0.031,
                                              color: Color(0xff2a6427),
                                            ),
                                          ),
                                          Text(
                                            "(at work, school, home)  ",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize:
                                                  screenSize.height * 0.020,
                                              color: Color(0xff2a6427)
                                                  .withOpacity(0.50),
                                            ),
                                          ),
                                          //<<<<<<<<<<<<<<<<<<<<<<< C O L U M N ---E  N  D >>>>>>>>>>>>>>>>>>>>>>>
                                        ],
                                      ),
                                    ),
                                    //
                                    //
                                    //************************************ A  C  T  I  V  I  T  Y -- L  E  V  E  L**********************************  */
                                    //
                                    //
                                    // level of activity text and radio buttons

                                    // SizedBox(height: screenSize.height * 0.01),
                                    //activity level very low
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: screenSize.width * 0.25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Radio(
                                              value: 1.2,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: Text(
                                              "Very low",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.023,
                                                color: Color(0xff000500),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "little or No Exercise ",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                color: Color(0xff2a6427)
                                                    .withOpacity(0.50),
                                              ),
                                            ),
                                          ),
                                          //activity level  low
                                          ListTile(
                                            leading: Radio(
                                              value: 1.375,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: Text(
                                              "Low",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.023,
                                                color: Color(0xff000500),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "Light exercise/sports 1-3 days/week",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                color: Color(0xff2a6427)
                                                    .withOpacity(0.50),
                                              ),
                                            ),
                                          ),
                                          //activity level  high
                                          ListTile(
                                            leading: Radio(
                                              value: 1.55,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: Text(
                                              "Average",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.023,
                                                color: Color(0xff000500),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "Moderate exercise/sports 3-5 days/week ",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                color: Color(0xff2a6427)
                                                    .withOpacity(0.50),
                                              ),
                                            ),
                                          ),
                                          //activity level  high
                                          ListTile(
                                            leading: Radio(
                                              value: 1.725,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: Text(
                                              "High",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.023,
                                                color: Color(0xff000500),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "Hard exercise /sports 6-7 days a week ",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                color: Color(0xff2a6427)
                                                    .withOpacity(0.50),
                                              ),
                                            ),
                                          ),
                                          //activity level very  high
                                          ListTile(
                                            leading: Radio(
                                              value: 1.9,
                                              groupValue: _activitylevel,
                                              onChanged: (double value) {
                                                setState(() {
                                                  _activitylevel = value;
                                                });
                                              },
                                            ),
                                            title: Text(
                                              "Very High",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.023,
                                                color: Color(0xff000500),
                                              ),
                                            ),
                                            subtitle: Text(
                                              "Very hard exercise/sports and physical job or 2X training",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize:
                                                    screenSize.height * 0.018,
                                                color: Color(0xff2a6427)
                                                    .withOpacity(0.50),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.04,
                                    ),
                                    // //>>>>>>>>>>>>>>>>>>>>>>>>> W O R K O U T --- A C T I V I T Y -- L E V E L >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                                    // Container(
                                    //   margin:
                                    //       EdgeInsets.only(left: screenSize.width * 0.04),
                                    //   child: Text(
                                    //     "WORKOUT ACTIVITY LEVEL :",
                                    //     style: TextStyle(
                                    //       fontFamily: "UniSansW01-Regular",
                                    //       fontSize: screenSize.height * 0.031,
                                    //       color: Color(0xff2a6427),
                                    //     ),
                                    //   ),
                                    // ),

                                    // // LIST TILE STARTS WORKOUT
                                    // ListTile(
                                    //   dense: true,
                                    //   leading: Radio(
                                    //     value: 'Very Low',
                                    //     groupValue: _activitylevelWORKOUT,
                                    //     onChanged: (String value) {
                                    //       setState(() {
                                    //         _activitylevelWORKOUT = value;
                                    //       });
                                    //     },
                                    //   ),
                                    //   title: Text(
                                    //     "Very Low",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.023,
                                    //       color: Color(0xff000500),
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     "No Workouts",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.018,
                                    //       color: Color(0xff2a6427).withOpacity(0.50),
                                    //     ),
                                    //   ),
                                    // ),
                                    // ListTile(
                                    //   dense: true,
                                    //   leading: Radio(
                                    //     value: 'Low',
                                    //     groupValue: _activitylevelWORKOUT,
                                    //     onChanged: (String value) {
                                    //       setState(() {
                                    //         _activitylevelWORKOUT = value;
                                    //       });
                                    //     },
                                    //   ),
                                    //   title: Text(
                                    //     "Low",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.023,
                                    //       color: Color(0xff000500),
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     "Workouts 1-3 days a week",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.018,
                                    //       color: Color(0xff2a6427).withOpacity(0.50),
                                    //     ),
                                    //   ),
                                    // ),
                                    // ListTile(
                                    //   dense: true,
                                    //   leading: Radio(
                                    //     value: 'Average',
                                    //     groupValue: _activitylevelWORKOUT,
                                    //     onChanged: (String value) {
                                    //       setState(() {
                                    //         _activitylevelWORKOUT = value;
                                    //       });
                                    //     },
                                    //   ),
                                    //   title: Text(
                                    //     "Average",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.023,
                                    //       color: Color(0xff000500),
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     "Workout 4-5 days a week",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.018,
                                    //       color: Color(0xff2a6427).withOpacity(0.50),
                                    //     ),
                                    //   ),
                                    // ),
                                    // ListTile(
                                    //   dense: true,
                                    //   leading: Radio(
                                    //     value: 'High',
                                    //     groupValue: _activitylevelWORKOUT,
                                    //     onChanged: (String value) {
                                    //       setState(() {
                                    //         _activitylevelWORKOUT = value;
                                    //       });
                                    //     },
                                    //   ),
                                    //   title: Text(
                                    //     "High",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.023,
                                    //       color: Color(0xff000500),
                                    //     ),
                                    //   ),
                                    //   subtitle: Text(
                                    //     "Workouts everyday",
                                    //     style: TextStyle(
                                    //       fontFamily: "Montserrat",
                                    //       fontSize: screenSize.height * 0.018,
                                    //       color: Color(0xff2a6427).withOpacity(0.50),
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: screenSize.height * 0.02,
                                    // ),
                                    // start activity button
                                    Container(
                                      height: screenSize.height * 0.05,
                                      margin: EdgeInsets.only(
                                        left: screenSize.width * 0.2,
                                        right: screenSize.width * 0.30,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xffe4d7cb),
                                        borderRadius:
                                            BorderRadius.circular(50.00),
                                      ),
                                      child: FlatButton(
                                        onPressed: () => {
                                          print('gender value ' + _gender),
                                          print('Height  value ' +
                                              _heightControler.text.toString()),
                                          print('weight  value ' +
                                              _weightControler.text.toString()),
                                          print('goalweight  value ' +
                                              _goalWeightControler.text
                                                  .toString()),
                                          print('activity level ' +
                                              _activitylevel.toString()),
                                          model.startPlan(
                                              _gender,
                                              _heightControler.text,
                                              _weightControler.text,
                                              _goalWeightControler.text,
                                              _custData.custDateOfBirth,
                                              _activitylevel),
                                          model.hasErrorMessage
                                              ? WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                  (_) => _showErrorMessage(
                                                    context,
                                                    model.errorMessage,
                                                  ),
                                                )
                                              : Container(),
                                        },
                                        // DatabaseService()
                                        //     .addPlanData(({'planid': 'dsad'})),
                                        child: Center(
                                          child: Text(
                                            "Start plan",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "UniSansRegular",
                                              fontSize:
                                                  screenSize.height * 0.023,
                                              color: Color(0xff5f2424),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: screenSize.height * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    model.state == ViewState.Busy ? Loading() : Container(),
                  ],
                ),
              ),
      ),
    );
  }
}

_showErrorMessage(BuildContext context, String error) async {
  showModalBottomSheet(
    context: (context),
    builder: (context) => UIHelper().showErrorButtomSheet(context, error),
  );
}
