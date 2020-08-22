import 'package:flutter/material.dart';

class CustStartPlan extends StatefulWidget {
  @override
  _CustStartPlanState createState() => _CustStartPlanState();
}

enum SingingCharacter { male, female }

class _CustStartPlanState extends State<CustStartPlan> {
  String _activitylevel;
  String _activitylevelWORKOUT;
  SingingCharacter _character = SingingCharacter.female;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            //upper header container
            Container(
              height: screenSize.height * 0.30,
              width: screenSize.width,
              child: Column(
                children: <Widget>[
                  // backbutton and signout container
                  Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenSize.width * 0.04,
                        ),
                        Container(
                          height: screenSize.height * 0.09,
                          width: screenSize.width * 0.09,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "lib/assets/images/AppIcons/back_white.png"),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.00, 3.00),
                                color: Color(0xff000000).withOpacity(0.16),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Sign out",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "UniSansRegular",
                            fontSize: screenSize.height * 0.03,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.06,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  //startplan and image container
                  Container(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: screenSize.width * 0.09,
                        ),
                        Text(
                          "Start\nyour plan",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.045,
                            color: Color(0xff000000),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: screenSize.height * 0.05,
                        ),
                        SizedBox(
                          width: screenSize.width * 0.04,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //>>>>>>>> F O R M  -- C O N T A I N E R >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            Expanded(
              flex: 1,
              child: Container(
                //height: screenSize.height * 0.609,

                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Color(0xffe4d7cb).withOpacity(0.36),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(screenSize.width * 0.3),
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
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: screenSize.height * 0.06,
                      ),
                      //container 1 for gender

                      Container(
                        margin: EdgeInsets.only(left: screenSize.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "Gender",
                              style: TextStyle(
                                fontFamily: "UniSansW01-Regular",
                                fontSize: screenSize.height * 0.031,
                                color: Color(0xff2a6427),
                              ),
                            ),
                            Container(
                                child: Row(
                              children: <Widget>[
                                Radio(
                                  value: SingingCharacter.female,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: screenSize.height * 0.026,
                                    color: Color(0xff000500),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.09,
                                ),
                                Radio(
                                  value: SingingCharacter.male,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter value) {
                                    setState(() {
                                      _character = value;
                                    });
                                  },
                                ),
                                new Text(
                                  "Male",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: screenSize.height * 0.026,
                                    color: Color(0xff000500),
                                  ),
                                )
                              ],
                            )),

                            //  h e i g h t

                            Text(
                              "Height",
                              style: TextStyle(
                                fontFamily: "UniSansW01-Regular",
                                fontSize: screenSize.height * 0.031,
                                color: Color(0xff2a6427),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    border: Border.all(
                                      width: screenSize.width * 0.003,
                                      color: Color(0xff707070),
                                    ),
                                    borderRadius: BorderRadius.circular(16.00),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.1,
                                ),
                                //button containers
                                // container for ft/in
                                Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd6d8ff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.00),
                                      bottomLeft: Radius.circular(16.00),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ft/in",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.022,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                // container for cm
                                Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.00),
                                      bottomRight: Radius.circular(16.00),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "cm",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.022,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            //<<<<<<<<<<<<<<<<<<<<<<<< W E I G H T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                            Text(
                              "Weight",
                              style: TextStyle(
                                fontFamily: "UniSansW01-Regular",
                                fontSize: screenSize.height * 0.031,
                                color: Color(0xff2a6427),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                new Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    border: Border.all(
                                      width: screenSize.width * 0.003,
                                      color: Color(0xff707070),
                                    ),
                                    borderRadius: BorderRadius.circular(16.00),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.1,
                                ),
                                //button containers
                                // container for kg
                                Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd6d8ff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.00),
                                      bottomLeft: Radius.circular(16.00),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Kg",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.022,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                // container for lb
                                new Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.00),
                                      bottomRight: Radius.circular(16.00),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "lb",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.022,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            //<<<<<<<<<<<<<<<<<<<<<<<< G O A L - W E I G H T >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                            Text(
                              "Goal weight",
                              style: TextStyle(
                                fontFamily: "UniSansW01-Regular",
                                fontSize: screenSize.height * 0.031,
                                color: Color(0xff2a6427),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Row(
                              children: <Widget>[
                                new Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    border: Border.all(
                                      width: screenSize.width * 0.003,
                                      color: Color(0xff707070),
                                    ),
                                    borderRadius: BorderRadius.circular(16.00),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.1,
                                ),
                                //button containers
                                // container for Kg
                                Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd6d8ff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.00),
                                      bottomLeft: Radius.circular(16.00),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Kg",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.022,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                // container for Lb
                                new Container(
                                  height: screenSize.height * 0.05,
                                  width: screenSize.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.00),
                                      bottomRight: Radius.circular(16.00),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Lb",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: screenSize.height * 0.022,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: screenSize.height * 0.04,
                            ),
                            Text(
                              "Level of activity during the day\nEXCL. WORKOUTS",
                              style: TextStyle(
                                fontFamily: "UniSansW01-Regular",
                                fontSize: screenSize.height * 0.031,
                                color: Color(0xff2a6427),
                              ),
                            ),
                            Text(
                              "(at work, school, home)  ",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: screenSize.height * 0.020,
                                color: Color(0xff2a6427).withOpacity(0.50),
                              ),
                            ),
                            //<<<<<<<<<<<<<<<<<<<<<<< C O L U M N ---E  N  D >>>>>>>>>>>>>>>>>>>>>>>
                          ],
                        ),
                      ),

                      // level of activity text and radio buttons

                      // SizedBox(height: screenSize.height * 0.01),
                      //activity level very low
                      Container(
                        padding:
                            EdgeInsets.only(right: screenSize.width * 0.25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              leading: Radio(
                                value: 'very Low',
                                groupValue: _activitylevel,
                                onChanged: (String value) {
                                  setState(() {
                                    _activitylevel = value;
                                  });
                                },
                              ),
                              title: Text(
                                "Very low",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.023,
                                  color: Color(0xff000500),
                                ),
                              ),
                              subtitle: Text(
                                "Low activity job, easy housework, walk \nonly to a bus",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.018,
                                  color: Color(0xff2a6427).withOpacity(0.50),
                                ),
                              ),
                            ),
                            //activity level  low
                            ListTile(
                              leading: Radio(
                                value: 'Low',
                                groupValue: _activitylevel,
                                onChanged: (String value) {
                                  setState(() {
                                    _activitylevel = value;
                                  });
                                },
                              ),
                              title: Text(
                                "Low",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.023,
                                  color: Color(0xff000500),
                                ),
                              ),
                              subtitle: Text(
                                "Low activity job, easy housework, walk \nonly to a bus",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.018,
                                  color: Color(0xff2a6427).withOpacity(0.50),
                                ),
                              ),
                            ),
                            //activity level  high
                            ListTile(
                              leading: Radio(
                                value: 'Average',
                                groupValue: _activitylevel,
                                onChanged: (String value) {
                                  setState(() {
                                    _activitylevel = value;
                                  });
                                },
                              ),
                              title: Text(
                                "Average",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.023,
                                  color: Color(0xff000500),
                                ),
                              ),
                              subtitle: Text(
                                "Low activity job, easy housework, walk \nonly to a bus",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.018,
                                  color: Color(0xff2a6427).withOpacity(0.50),
                                ),
                              ),
                            ),
                            //activity level  high
                            ListTile(
                              leading: Radio(
                                value: 'High',
                                groupValue: _activitylevel,
                                onChanged: (String value) {
                                  setState(() {
                                    _activitylevel = value;
                                  });
                                },
                              ),
                              title: Text(
                                "High",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.023,
                                  color: Color(0xff000500),
                                ),
                              ),
                              subtitle: Text(
                                "Low activity job, easy housework, walk \nonly to a bus",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.018,
                                  color: Color(0xff2a6427).withOpacity(0.50),
                                ),
                              ),
                            ),
                            //activity level very  high
                            ListTile(
                              leading: Radio(
                                value: 'Very High',
                                groupValue: _activitylevel,
                                onChanged: (String value) {
                                  setState(() {
                                    _activitylevel = value;
                                  });
                                },
                              ),
                              title: Text(
                                "Very High",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.023,
                                  color: Color(0xff000500),
                                ),
                              ),
                              subtitle: Text(
                                "Low activity job, easy housework, walk \nonly to a bus",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: screenSize.height * 0.018,
                                  color: Color(0xff2a6427).withOpacity(0.50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //>>>>>>>>>>>>>>>>>>>>>>>>> W O R K O U T --- A C T I V I T Y -- L E V E L >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenSize.width * 0.04),
                        child: Text(
                          "WORKOUT ACTIVITY LEVEL :",
                          style: TextStyle(
                            fontFamily: "UniSansW01-Regular",
                            fontSize: screenSize.height * 0.031,
                            color: Color(0xff2a6427),
                          ),
                        ),
                      ),

                      // LIST TILE STARTS WORKOUT
                      ListTile(
                        dense: true,
                        leading: Radio(
                          value: 'Very Low',
                          groupValue: _activitylevelWORKOUT,
                          onChanged: (String value) {
                            setState(() {
                              _activitylevelWORKOUT = value;
                            });
                          },
                        ),
                        title: Text(
                          "Very Low",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.023,
                            color: Color(0xff000500),
                          ),
                        ),
                        subtitle: Text(
                          "No Workouts",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.018,
                            color: Color(0xff2a6427).withOpacity(0.50),
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: Radio(
                          value: 'Low',
                          groupValue: _activitylevelWORKOUT,
                          onChanged: (String value) {
                            setState(() {
                              _activitylevelWORKOUT = value;
                            });
                          },
                        ),
                        title: Text(
                          "Low",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.023,
                            color: Color(0xff000500),
                          ),
                        ),
                        subtitle: Text(
                          "Workouts 1-3 days a week",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.018,
                            color: Color(0xff2a6427).withOpacity(0.50),
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: Radio(
                          value: 'Average',
                          groupValue: _activitylevelWORKOUT,
                          onChanged: (String value) {
                            setState(() {
                              _activitylevelWORKOUT = value;
                            });
                          },
                        ),
                        title: Text(
                          "Average",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.023,
                            color: Color(0xff000500),
                          ),
                        ),
                        subtitle: Text(
                          "Workout 4-5 days a week",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.018,
                            color: Color(0xff2a6427).withOpacity(0.50),
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: Radio(
                          value: 'High',
                          groupValue: _activitylevelWORKOUT,
                          onChanged: (String value) {
                            setState(() {
                              _activitylevelWORKOUT = value;
                            });
                          },
                        ),
                        title: Text(
                          "High",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.023,
                            color: Color(0xff000500),
                          ),
                        ),
                        subtitle: Text(
                          "Workouts everyday",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: screenSize.height * 0.018,
                            color: Color(0xff2a6427).withOpacity(0.50),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      // start activity button
                      Container(
                        height: screenSize.height * 0.05,
                        margin: EdgeInsets.only(
                          left: screenSize.width * 0.2,
                          right: screenSize.width * 0.30,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffe4d7cb),
                          borderRadius: BorderRadius.circular(50.00),
                        ),
                        child: Center(
                          child: Text(
                            "Start plan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "UniSansRegular",
                              fontSize: screenSize.height * 0.023,
                              color: Color(0xff5f2424),
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
          ],
        ),
      ),
    );
  }
}
